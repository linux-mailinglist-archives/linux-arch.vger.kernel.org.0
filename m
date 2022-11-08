Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3326216E4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKHOfk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 09:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiKHOfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 09:35:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A819FFC;
        Tue,  8 Nov 2022 06:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D2A615E2;
        Tue,  8 Nov 2022 14:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4264AC433C1;
        Tue,  8 Nov 2022 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667918138;
        bh=iRCXVVce81K56uY3wSFuiW3EJnWmIFxRfYgwuiKPlUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agtcviDySGTRQAGRdA4+4QiePjTCK4ixmbAAO9VyyCkejdj6bpetZ+2TUOth68dlQ
         3AawLukUepPql4XJYdS9DAa+ussxB4UHOaOnj2u4TlVfluF/LxGxIjEynOXFyhKY9Y
         W/ljr1/Y6gBrO1oq9/yLuZyvDo56Xzvj2rZ/SS4DAlh/oAdr1qC1mF0blUMbJ2zOyp
         ULAhto29r3IV5daLcoq/DELL9FC1GKiz+0H6/pf1pnL61Q13wKXqOMbVdFDkC0QzSw
         fGrkLPwuPHEh1mqLeS2wuVyGAFXK7JJsbofMpdQUcKzJzaAKTq4CoaxFxlsTEE1qqx
         AWEvcCOS8j2YA==
Date:   Tue, 8 Nov 2022 07:35:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     xiafukun <xiafukun@huawei.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     arnd@arndb.de, keescook@chromium.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, yusongping@huawei.com,
        zhaowenhui8@huawei.comx
Subject: Re: vmlinux.lds.h: Bug report: unable to handle page fault when
 start the virtual machine with qemu
Message-ID: <Y2ppOJ4zguDznRAc@dev-arch.thelio-3990X>
References: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
 <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
 <b714ad78-4689-ad0b-9316-efcc1665f6bf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b714ad78-4689-ad0b-9316-efcc1665f6bf@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 08, 2022 at 03:46:32PM +0800, xiafukun wrote:
> Thank you for your reply.
> We tested your changes to this patch and did fix the issue. Following the
> solution you provided, we recompile the kernel and successfully start the
> virtual machine.

Thank you a lot for testing and sorry about the breakage in the first
place :(

Ard, were you going to send a patch? Feel free to preemptively add:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

if so; otherwise, I can send one later today.

> 在 2022/11/8 0:00, Ard Biesheuvel 写道:
> > 
> > That patch looks incorrect to me. Without CONFIG_SMP, the PERCPU
> > sections are not instantiated, and the only copy of those variables is
> > created in the ordinary .data/.bss sections
> > 
> > Does the change below fix the issue for you?
> > 
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -347,6 +347,7 @@
> >  #define DATA_DATA                                                      \
> >         *(.xiptext)                                                     \
> >         *(DATA_MAIN)                                                    \
> > +       *(.data..decrypted)                                             \
> >         *(.ref.data)                                                    \
> >         *(.data..shared_aligned) /* percpu related */                   \
> >         MEM_KEEP(init.data*)                                            \
> > @@ -995,7 +996,6 @@
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >  #define PERCPU_DECRYPTED_SECTION                                       \
> >         . = ALIGN(PAGE_SIZE);                                           \
> > -       *(.data..decrypted)                                             \
> >         *(.data..percpu..decrypted)                                     \
> >         . = ALIGN(PAGE_SIZE);
> >  #else
