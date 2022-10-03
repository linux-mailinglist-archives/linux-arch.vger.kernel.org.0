Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F245F394F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJCWt3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJCWt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD341FCD2;
        Mon,  3 Oct 2022 15:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8299461211;
        Mon,  3 Oct 2022 22:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E595C433C1;
        Mon,  3 Oct 2022 22:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664837366;
        bh=599phx3z//XkaqQjtagJzQ7sjVck2S3daFrsAp1kj9Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QLv5iS0E6SRGs4sM9XRL0BBZLUhIfUxSR8v33w/0yNOjsS7/zaa/J5pRp02CjSW1X
         BJMmIOfTmxPEIqnjt+aqWykwg2+4xJbqMPdPXKyfUuQrLlVT1ZhT3mb/MXcsAfkSte
         j3jI7s5J5kSjDMCX5HEe/KOsS15VJT/TyubjkJG/I3/JGhaYvBsglab9Og9m+jnu0U
         Ql9W4Szdv0tI0KTMxSVIa2tkETjjmq+WAulpSZ3QbGTRtw0VEe3Qa7dnlLKTq7/fnw
         8nibutltZhCHc6zp6nAtolnV5KXm5a6jRN7mxWkvh9XL3C9OVbLEuzmZ4UpZubrtXQ
         x+CKQnZ2NO2dg==
Message-ID: <bcfca48f-e02a-fc43-fb92-9cc119e2d28f@kernel.org>
Date:   Mon, 3 Oct 2022 15:49:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com>
 <202210031134.B0B6B37@keescook>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <202210031134.B0B6B37@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 11:39, Kees Cook wrote:
> On Thu, Sep 29, 2022 at 03:29:19PM -0700, Rick Edgecombe wrote:
>> [...]
>> Still allow FOLL_FORCE to write through shadow stack protections, as it
>> does for read-only protections.
> 
> As I asked in the cover letter: why do we need to add this for shstk? It
> was a mistake for general memory. :P

For debuggers, which use FOLL_FORCE, quite intentionally, to modify 
text.  And once a debugger has ptrace write access to a target, shadow 
stacks provide exactly no protection -- ptrace can modify text and all 
registers.

But /proc/.../mem may be a different story, and I'd be okay with having 
FOLL_PROC_MEM for legacy compatibility via /proc/.../mem and not 
allowing that to access shadow stacks.  This does seem like it may not 
be very useful, though.

