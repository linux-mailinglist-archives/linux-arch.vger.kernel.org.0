Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2F3C6521
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 22:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhGLUxc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 16:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhGLUxb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 16:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9A7461002;
        Mon, 12 Jul 2021 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626123043;
        bh=5Yz8pj87dNRBgw4Q7oYfiZ9EXtTuJ3acNLpxDNeoRVs=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=UZbSw8el3xv8YAaabpVDF/zw1v1jv1KtsmBbbIVgEYMfD2fC9F06PyJE8H+D/EH5M
         lMzdgMpQU9h3yxZEy/nT2iakaSFcagqURnDolEyWxEkRlaESSGzYDcUiFKfLtEsI13
         YFj91zrlrvqm2KHe6lJWCNpkLs7eVSj6dGoBuI6rXKBaRrB+2c11LsoAQrTzV+u+H1
         8OVGpgL31RNQ5VCQaaQaWaDvocE7EUf/ApXWeLaM8vkwuxEfafeYNpfo/jAD2tHhhb
         ghJ5NGvPgTSBef/2l0n4qhgH8mwF30ustmYTmO2vA3bzyEJQFxTxW/3u0OLm7dKY3A
         m8i54cOo5bVvQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B048E27C0054;
        Mon, 12 Jul 2021 16:50:41 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Mon, 12 Jul 2021 16:50:41 -0400
X-ME-Sender: <xms:IavsYOMbsyzxS5A6tMEkx8eJQ6Y8QHCItI68URtpNTJ6WO2talreSg>
    <xme:IavsYM_tispzCjezSckf2JsHprY4RZKCxb8UWrtI1Yj1UIo9W1lnlfbcALd1F8BO0
    T84HZZi6FQpXnB7_ZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdetnhguhicunfhuthhomhhirhhskhhifdcuoehluhhtohes
    khgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedthfehtedtvdetvdetudfgue
    euhfdtudegvdelveelfedvteelfffgfedvkeegfeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoheppehk
    vghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:IavsYFSTA8OkWOzfQoHnpnz-Qpio7zVH5i8EFZjuQY_TLhsrmf4PnA>
    <xmx:IavsYOueNi05XDuLrj-lkwHcOmxTo8Clq_XNDe0iBGRr835cbWRByA>
    <xmx:IavsYGeQ8NlX3UWT2VzOw4YoJJV44it4HDyK9jchDMSyudbFFLanKg>
    <xmx:IavsYOlGaPt4XFJlI21Sc0Yqm1Haiq5hjVht15maJcVZxrf_6IROYg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 43998A03578; Mon, 12 Jul 2021 16:50:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-531-g1160beca77-fm-20210705.001-g1160beca
Mime-Version: 1.0
Message-Id: <2c7820bf-e502-4fd6-8fae-2dbf46c94a7e@www.fastmail.com>
In-Reply-To: <CAFOO9hwU3oS9Z2v-uqK5U_B+Sdy-whU3rd_BcecO3ogPHmoFXA@mail.gmail.com>
References: <CAFOO9hwU3oS9Z2v-uqK5U_B+Sdy-whU3rd_BcecO3ogPHmoFXA@mail.gmail.com>
Date:   Mon, 12 Jul 2021 13:50:19 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "vivek thakkar" <vthakkar.systems@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     linux-arch@vger.kernel.org
Subject: Re: x86 system call (using sysenter) perf regression
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sun, Jul 11, 2021, at 9:17 PM, vivek thakkar wrote:
> We ran a test to measure the syscall performance on two different
> kernels (v4.9.x and v4.0.9). The program is as simple as this:
> 
> for (int i =0; i< 100'000'000; i++) {
>      syscall(SYS_getpid);
> }
> 
> The program was built for x86 and was using the "vdso" mechanism to
> generate the system call and we could confirm that it was
> transitioning into the kernel using sysenter.
> 
> We find that the time taken by each system call takes 10ns more in
> 4.9.x  as compared to 4.0.9. On deeper analysis, we found that there
> are 40 more instructions that get executed in the newer kernel version
> - the user space transitioning mechanism based off of vdso remains the
> same.
> 
> commit 5f310f739b4cc343f3f087681e41bbc2f0ce902d
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Mon Oct 5 17:48:15 2015 -0700
> 
>     x86/entry/32: Re-implement SYSENTER using the new C path
> 
> Is that something that is already known to the community?
> 

Yes. We made a conscious decision to trade a bit of performance for a lot of maintainability, especially for a legacy-ish path. The old SYSENTER code was a mess.

> Regards,
> Vivek Thakkar
> 
