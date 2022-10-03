Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9C5F394A
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJCWqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJCWqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3F4AD7A;
        Mon,  3 Oct 2022 15:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA22E611E1;
        Mon,  3 Oct 2022 22:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA033C433B5;
        Mon,  3 Oct 2022 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664837176;
        bh=GNpI8alyczsGJm34nf0Ut1uPwaRQOXVFL9dF4cNtZQk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=l5NrlOjA+xnJQvJdHfqNQtithtntGXyAPYfV3GG/kEUPwiYoqsUxCrVI8EnM7uOSV
         y+uJXh6HzaSsasiix5wDQ3eKm17CWZDkmAIPFun+vuyX71NEX7IID3ZI2NDAvu8t0i
         V7TrPBva9V8VVA/6kQavONictQcVM+GtvZ0D2KyvRNOMh9lICAMTOuMhN/4hh29Fw0
         cyaUBvZzwNy3hCBib7cUUW3RvfxoBqif7iROJ1aXMyzAn5MlOItZWnZ+Mg9zgADBZG
         0BMjzGGKPbBT7liCtrLGFC4A/o2norD2d0SakTgBQjQy+F4464KVPaoqDJRSU7mH+i
         JReRf4jdZeSuw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9AB8827C0054;
        Mon,  3 Oct 2022 18:46:13 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Mon, 03 Oct 2022 18:46:13 -0400
X-ME-Sender: <xms:NGY7Y7fHcnsuAMA0Bi3LK5VTkHNxK595Yxp5kJMT1yMgMc0wTQ_3wg>
    <xme:NGY7YxOP98Ws8OzfeVlnbWDPqeMBbtFA1Iv7raagQz7tNe6bs9dAcfjGtF1aADO1N
    uVIG5CVk5K26ClhQ1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeitddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepveffgfevhfeiteduueetgeevvdevudevteefveffudeiveefuddt
    leeitdeludfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:NGY7Y0hV1wv-Hz3Gdsf33qXZJ6bzUgNhl5E3h5Lr-n5VM-PiNI3uCQ>
    <xmx:NGY7Y89rkdQ8MTimT2SfC3SsJG5eQRrzh9AnjaE56mqSeMjsxqeE5Q>
    <xmx:NGY7Y3ul3kmzZrwKUo6K-M8GqyoMGcCAhjoFWIvdI2b32kk-sHMv1Q>
    <xmx:NWY7Y-N7_--bM1kLIS8Z3bQ6snCjlaudE5oMUSuN4WJacDR2BQRN1Q>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1F2B531A0063; Mon,  3 Oct 2022 18:46:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <b8b3caab-9f0c-4230-8d7b-debd7f79cdb9@app.fastmail.com>
In-Reply-To: <202210031530.9CFB62B39F@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-31-rick.p.edgecombe@intel.com>
 <202210031530.9CFB62B39F@keescook>
Date:   Mon, 03 Oct 2022 15:45:50 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "Mike Rapoport" <rppt@kernel.org>, jamorris@linux.microsoft.com,
        dethoma@microsoft.com
Subject: Re: [PATCH v2 30/39] x86: Expose thread features status in
 /proc/$PID/arch_status
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, Oct 3, 2022, at 3:37 PM, Kees Cook wrote:
> On Thu, Sep 29, 2022 at 03:29:27PM -0700, Rick Edgecombe wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> 
>> Applications and loaders can have logic to decide whether to enable CET.
>> They usually don't report whether CET has been enabled or not, so there
>> is no way to verify whether an application actually is protected by CET
>> features.
>> 
>> Add two lines in /proc/$PID/arch_status to report enabled and locked
>> features.
>> 
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> [Switched to CET, added to commit log]
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> 
>> ---
>> 
>> v2:
>>  - New patch
>> 
>>  arch/x86/kernel/Makefile     |  2 ++
>>  arch/x86/kernel/fpu/xstate.c | 47 ---------------------------
>>  arch/x86/kernel/proc.c       | 63 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 65 insertions(+), 47 deletions(-)
>>  create mode 100644 arch/x86/kernel/proc.c
>
> This is two patches: one to create proc.c, the other to add CET support.
>
> I found where the "arch_status" conversation was:
> https://lore.kernel.org/all/CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com/
>
> Andy, what did you mean "make sure that everything in it is namespaced"?
> Everything already has a field name. And arch_status doesn't exactly
> solve having compat fields -- it still needs to be handled manually?
> Anyway... we have arch_status, so I guess it's fine.

I think I meant that, since it's "arch_status" not "x86_status", the fields should have names like "x86.Thread_features".  Otherwise if another architecture adds a Thread_features field, then anything running under something like qemu userspace emulation could be confused.

Assuming that's what I meant, I think my comment still stands :)
