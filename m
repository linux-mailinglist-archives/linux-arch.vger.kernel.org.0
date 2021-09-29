Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19DE41BE47
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 06:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbhI2Edp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 00:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhI2Edo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 00:33:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F3FC611BD;
        Wed, 29 Sep 2021 04:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632889922;
        bh=0JwZBuC9ISIKWkfaCHpZoe2xKe6eZgUj8P+e9dRgmcA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=EK+ZaX3RZ98lBZT/cEE3maXj+cA8JmNET5/gOuKZsMKKbXgo21lvmEuXLkapNfJ1F
         nCe+LZxlq7xsF7LCPUxhcSTjYuhTX0elDTzppiQ/BtSOV4ubsa2kSQNdb/vvi6gcS5
         NEXm8GIF+c/VBbwEODTij153Ke8nIzKLXyLwwEpA8cISVqvPTyMRSqXx+eiVrxTFXN
         UxgFt4fZa91b4KbOgWiZkU2l6+gzvlSSLeZFvLotJMyd696M7IEkMFCaH2on21+nXb
         XsJo2rTuoDydcSJflndUnzajwyqp8jgEAU8BgOHjHYO8DZstSK11aWk1FBylToTu3U
         pbVpY+rhZ3Olw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5C7E327C0054;
        Wed, 29 Sep 2021 00:31:59 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Wed, 29 Sep 2021 00:31:59 -0400
X-ME-Sender: <xms:PuxTYV9qNBxPuc04zhunRdT6LdYI3w2UxMeJ_Df0T89Zrj_OZBLeLQ>
    <xme:PuxTYZvAbNOkHzvpyoR6MJ8qoNqUb5Mi313DCZ92oQkKa3ycEwwmwXGKLMcbrpBR2
    MRYv0_1XZmW68kuEFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:PuxTYTCcnaoUDSJrfsJ-TPJt_GeQFTF8y5mBTXqlzMsH6ry9Cm_PKA>
    <xmx:PuxTYZcMkiAvO4K5GV0aujK4M5YchwTCuV1JjQTfOwIHfVO66NfOVQ>
    <xmx:PuxTYaPK9t5E9pY0zOQw7v48lhsbeDMK-KSJBZgKa4nHMMVINXFZOQ>
    <xmx:P-xTYRMaHat97vvaAqnOxs4KneZtzP5xDc-pBAoPiatYfM0_qJ7byEtTCV4>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6378621E0063; Wed, 29 Sep 2021 00:31:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <456bf9cf-87b8-4c3d-ac0c-7e392bcf26de@www.fastmail.com>
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
Date:   Tue, 28 Sep 2021 21:31:34 -0700
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
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13, 2021, at 1:01 PM, Sohil Mehta wrote:
> User Interrupts Introduction
> ============================
>
> User Interrupts (Uintr) is a hardware technology that enables delivering
> interrupts directly to user space.
>
> Today, virtually all communication across privilege boundaries happens by going
> through the kernel. These include signals, pipes, remote procedure calls and
> hardware interrupt based notifications. User interrupts provide the foundation
> for more efficient (low latency and low CPU utilization) versions of these
> common operations by avoiding transitions through the kernel.
>

...

I spent some time reviewing the docs (ISE) and contemplating how this all fits together, and I have a high level question:

Can someone give an example of a realistic workload that would benefit from SENDUIPI and precisely how it would use SENDUIPI?  Or an example of a realistic workload that would benefit from hypothetical device-initiated user interrupts and how it would use them?  I'm having trouble imagining something that wouldn't work as well or better by simply polling, at least on DMA-coherent architectures like x86.

(I can imagine some benefit to a hypothetical improved SENDUIPI with idential user semantics but that supported a proper interaction with the scheduler and blocking syscalls.  But that's not what's documented in the ISE...)

--Andy

