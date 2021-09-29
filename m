Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78F641BD74
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbhI2Dch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 23:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243349AbhI2Dch (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 23:32:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 188596136A;
        Wed, 29 Sep 2021 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632886256;
        bh=WCjXIv7h+cvI30x4kcTCUOWtS0sTzxXS+pms9WS2R5w=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=pT1r5SFiZQttdoly5ySvJ0wy9GKMU6NNZ2hQ7mllvAOTYvb/8AjrLZwqiDb6OLq1/
         d4AkfvdeD7WHIx5vt8YEtfyGHi1CIV79T7L7bJfU5o2UFs9lNtwpGpBWQGO3Z+oJ1O
         7Da4vhkxb+EuXfc4mdAhFFQBYwaecYP1y9g6JLy/0dqUT3qQMY/M+i4eMv0OxbzIxK
         PqB484m6pD9MkVptjCWWoHJvpiWONqlpwPL4DdIRe7Y9r5qOF0kRef/lgWmzYBWBl4
         w0rObQEDEdeTTDoCRTbQRi7hKjcRTCX4eSE+tDOrtyFkoowFd873kkicHWxSdVIuNO
         Wkm87Gcu4oNjA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 23E2E27C0054;
        Tue, 28 Sep 2021 23:30:54 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Tue, 28 Sep 2021 23:30:54 -0400
X-ME-Sender: <xms:7d1TYcpBynFjX9dwv5ETADwstKZVMRQnpcJ86Sig_u94lANjdzB60Q>
    <xme:7d1TYSqbZ0So3QXRgAdXGZHu18vAuOcO1B0YJ9Y7LaLJzRvnccGYrieAYJEEom7jh
    i_zRa0S0xW2dbS_HUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:7d1TYRMlnaMhYK8KveqmK6msef7i_1-WAFahc39gefVObWR8pwFEng>
    <xmx:7d1TYT5Hn8VPeyxtz_yhSxipRPsNR0xXg0i7dRtqo_O2KqQ5OQUGdg>
    <xmx:7d1TYb7NPuxikq6JUHVmkIRqaQ3-9aFVFy8f-wOO9L2gNCWByyf4vQ>
    <xmx:7t1TYSJo-17mOdkG5LkTQegSlGgERPCKxteWdjcOXwA8FVr3eBlqRSeCJ4o>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 29AC621E0063; Tue, 28 Sep 2021 23:30:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
In-Reply-To: <20210913200132.3396598-12-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
Date:   Tue, 28 Sep 2021 20:30:27 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sohil Mehta" <sohil.mehta@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
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

On Mon, Sep 13, 2021, at 1:01 PM, Sohil Mehta wrote:
> Add a new system call to allow applications to block in the kernel and
> wait for user interrupts.
>

...

>
> When the application makes this syscall the notification vector is
> switched to a new kernel vector. Any new SENDUIPI will invoke the kernel
> interrupt which is then used to wake up the process.

Any new SENDUIPI that happens to hit the target CPU's ucode at a time when the kernel vector is enabled will deliver the interrupt.  Any new SENDUIPI that happens to hit the target CPU's ucode at a time when a different UIPI-using task is running will *not* deliver the interrupt, unless I'm missing some magic.  Which means that wakeups will be missed, which I think makes this whole idea a nonstarter.

Am I missing something?
