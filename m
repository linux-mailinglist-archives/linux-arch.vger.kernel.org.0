Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEA6872A0
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 01:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjBBA5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 19:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBBA5P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 19:57:15 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE95CD02;
        Wed,  1 Feb 2023 16:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JxMhQfqfZFKjqgX5e6WFjusNEH9w7UJyidC9GBl0BFE=; b=j7zrUF5m9QNeSdthOmzY2TpKll
        qPTRkZ/xmNsbI8HChk9xVt34XGsY89y73qsr5zxE8DZeUfti8whyBfVk+Ab+kjUnuReBRNDafmDAX
        /H78PrFrIrMaoRB9EbZbRJ4Zs7Jenz2oKhC7KateHZc+FvE4EURfaz4BFJx0r55ZQo1Vi5FrSgDFI
        yYZWY8336bh2CFJag9KhZHfpHAP/3O0kEIxOVWGnOYTJtYRxmwGwCH3+tArIpGL0USY+brYn81wps
        j1g4I7ez2NpxUerl3TovY+NE3eudMkGv9kBRvPwB8LQ6bXEAiIhDkDZeu/6wMFaHrstuWijmeUQlM
        aZbRGRgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pNNuX-005ZAk-1z;
        Thu, 02 Feb 2023 00:57:09 +0000
Date:   Thu, 2 Feb 2023 00:57:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9sKZTJI7V6qCNRJ@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
 <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
 <Y9rCBqwbLlLf1fHe@x1n>
 <Y9rlI6d5J2Y/YNQ+@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9rlI6d5J2Y/YNQ+@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 01, 2023 at 10:18:11PM +0000, Al Viro wrote:
> 	* logics for stack expansion includes this twist:
>         if (!(vma->vm_flags & VM_GROWSDOWN))
>                 goto map_err;
>         if (user_mode(regs)) {
>                 /* Accessing the stack below usp is always a bug.  The
>                    "+ 256" is there due to some instructions doing
>                    pre-decrement on the stack and that doesn't show up
>                    until later.  */
>                 if (address + 256 < rdusp())
>                         goto map_err;
>         }
>         if (expand_stack(vma, address))
>                 goto map_err;
> That's m68k; ISTR similar considerations elsewhere, but I could be
> wrong.

Hell, yes - 
        if (!(vma->vm_flags & VM_GROWSDOWN))
                goto bad_area;
        if (!(fault_code & FAULT_CODE_WRITE)) {
                /* Non-faulting loads shouldn't expand stack. */
                insn = get_fault_insn(regs, insn);
                if ((insn & 0xc0800000) == 0xc0800000) {
                        unsigned char asi;

                        if (insn & 0x2000)
                                asi = (regs->tstate >> 24);
                        else
                                asi = (insn >> 5);
                        if ((asi & 0xf2) == 0x82)
                                goto bad_area;
                }
        }
        if (expand_stack(vma, address))
                goto bad_area;

Note that it's very much not a bug - it's a nonfaulting (== speculative)
load, and the place where we are heading from bad_area in this case is
this in do_kernel_fault():
        if (!(fault_code & (FAULT_CODE_WRITE|FAULT_CODE_ITLB)) &&
            (insn & 0xc0800000) == 0xc0800000) {
                if (insn & 0x2000)
                        asi = (regs->tstate >> 24);
                else  
                        asi = (insn >> 5);
                if ((asi & 0xf2) == 0x82) {
                        if (insn & 0x1000000) {
                                handle_ldf_stq(insn, regs);
                        } else {
                                /* This was a non-faulting load. Just clear the
                                 * destination register(s) and continue with the next
                                 * instruction. -jj
                                 */
                                handle_ld_nf(insn, regs);
                        }
                        return;

(the name is misguiding - it covers userland stuff as well; in this
particular case the triggering instruction is non-priveleged)
