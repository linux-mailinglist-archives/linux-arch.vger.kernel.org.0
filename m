Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48B41F0F5
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354954AbhJAPPh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 11:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354868AbhJAPPh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Oct 2021 11:15:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D2C61A03;
        Fri,  1 Oct 2021 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633101233;
        bh=AN2KczzHH12GPIyjRmOqJEClIqeRchZXDMq1q/SMB9A=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=CwFRT8SokK/HWVzf7McAlR8ZCAMlc6y9V2UiDE5RwrmJp2ca4OU1YwRL8mP6GM39s
         pO4lkDw6HS2R3VlMw79ZT93TUlzVyqOk7fZo/HYTWy4h3VaHw3W5nMN90U4CYpCcEI
         L1vtNUyAy4Bi3JcLrLy2rHynpO/wSTqx6EvlVZeZOS0QK4Yx2EP3asWUdP9gR0rW+6
         5vw+QuBIxIDu91iWzrGTgLyWUq2uHan5ht4roXamlYb+/mcle94HpjJIdUr2rPZAeX
         Ok00D40w40K3DtAbOjHLRRJxtnlcKRHQCD1HSmzfc0jMUIF9kfqdBS5WorJaCJrPSC
         pXsRd3K0SIMLA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 41DE927C005A;
        Fri,  1 Oct 2021 11:13:50 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 01 Oct 2021 11:13:50 -0400
X-ME-Sender: <xms:rCVXYQyKU-wP9158rpGYIA6Wna6y97sWd-dkZ5a1wYc3MiRKBl8NHA>
    <xme:rCVXYUSrnqAgb0RPhyj-O3Lb3g039kEcNiTqZt6IjKraJjEXLSqV55s04MD8Vfx_V
    5P6_aDqsDllclBaNU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:rCVXYSVcfsOzYKsBRlwwwDNJOKwa7T58ktBwU56C2cxE917vh5G7yA>
    <xmx:rCVXYejllRAV3DUoYO_jmBahwxnXlS0ZmZuM_2tQZBHhpbxZ9AZ2Xw>
    <xmx:rCVXYSAYhRpOhQDWXRMj7ms6goy05oVqERViiWI0rtF8DmQQ3CS2Yg>
    <xmx:riVXYTyNDpBk5sDQXLXQAeEZPZOXzo0hZOdrowsBezGDn7FJLO6sxkiA1l8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4010121E0066; Fri,  1 Oct 2021 11:13:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1322-g921842b88a-fm-20210929.001-g921842b8
Mime-Version: 1.0
Message-Id: <0364c572-4bc2-4538-8d65-485dbfa81f0d@www.fastmail.com>
In-Reply-To: <87pmsp5aqx.ffs@tglx>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com> <877dex7tgj.ffs@tglx>
 <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com> <87tui162am.ffs@tglx>
 <25ba1e1f-c05b-4b67-b547-6b5dbc958a2f@www.fastmail.com> <87pmsp5aqx.ffs@tglx>
Date:   Fri, 01 Oct 2021 08:13:26 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Christian Brauner" <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Shuah Khan" <shuah@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        "Zeng Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Randy E Witt" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Ramesh Thomas" <ramesh.thomas@intel.com>,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 1, 2021, at 2:56 AM, Thomas Gleixner wrote:
> On Thu, Sep 30 2021 at 21:41, Andy Lutomirski wrote:
>> On Thu, Sep 30, 2021, at 5:01 PM, Thomas Gleixner wrote:
>
>> Now that I read the docs some more, I'm seriously concerned about this
>> XSAVE design.  XSAVES with UINTR is destructive -- it clears UINV.  If
>> we actually use this, then the whole last_cpu "preserve the state in
>> registers" optimization goes out the window.  So does anything that
>> happens to assume that merely saving the state doesn't destroy it on
>> respectable modern CPUs XRSTORS will #GP if you XRSTORS twice, which
>> makes me nervous and would need a serious audit of our XRSTORS paths.
>
> I have no idea what you are fantasizing about. You can XRSTORS five
> times in a row as long as your XSTATE memory image is correct.

I'm just reading TFM, which is some kind of dystopian fantasy.

11.8.2.4 XRSTORS

Before restoring the user-interrupt state component, XRSTORS verifies that UINV is 0. If it is not, XRSTORS
causes a general-protection fault (#GP) before loading any part of the user-interrupt state component. (UINV
is IA32_UINTR_MISC[39:32]; XRSTORS does not check the contents of the remainder of that MSR.)

So if UINV is set in the memory image and you XRSTORS five times in a row, the first one will work assuming UINV was zero.  The second one will #GP.  And:

11.8.2.3 XSAVES
After saving the user-interrupt state component, XSAVES clears UINV. (UINV is IA32_UINTR_MISC[39:32];
XSAVES does not modify the remainder of that MSR.)

So if we're running a UPID-enabled user task and we switch to a kernel thread, we do XSAVES and UINV is cleared.  Then we switch back to the same task and don't do XRSTORS (or otherwise write IA32_UINTR_MISC) and UINV is still clear.

And we had better clear UINV when running a kernel thread because the UPID might get freed or the kernel thread might do some CPL3 shenanigans (via EFI, perhaps? I don't know if any firmwares actually do this).

So all this seems to put UINV into the "independent" category of feature along with LBR.  And the 512-byte wastes from extra copies of the legacy area and the loss of the XMODIFIED optimization will just be collateral damage.
