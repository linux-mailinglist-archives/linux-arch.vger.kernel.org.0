Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3C7358E5
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jun 2023 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjFSNrX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jun 2023 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjFSNrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2023 09:47:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0257BD;
        Mon, 19 Jun 2023 06:47:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A73EC3200915;
        Mon, 19 Jun 2023 09:47:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 09:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1687182434; x=
        1687268834; bh=E2eLG5b+IZsgxO3zQfTIrYDsY9Sg2au6WKKO1Lx6xeE=; b=g
        pvfrGJ21CPVG9sS/TvMo/DrLLarXRNl4FhZ2jTK2h5yob6n9WXu04KOeZdYvRr4E
        PEYAlzix1SVOE5LnI+wv3D7m9jtajNuoHX7StOChJTRCLFetDQEykHXrk2unmyl8
        bI8x5OmsN+/xhsEfJozTKPFSbJQ/x7u33byFvExbBXoAu8Qt4STloybxWvGaAE+m
        Vs3tsVvL0alcP6Izg2sKpWIemsIMe8DYbsgOrwl6rLjkqV0AflftPwqKzrDELi0a
        KgAJSUuGcDAMik8JG4GbGcfDnYfGTbsT/i2HwQ/sorwnlO8Ra/vz5/m9SYVy9Eoo
        sbLG6TFQosbETbGhpnIkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687182434; x=1687268834; bh=E2eLG5b+IZsgx
        O3zQfTIrYDsY9Sg2au6WKKO1Lx6xeE=; b=FFwmbQlNyFWm05W13BYqeeyk3ol3d
        KIeyOC7+jobtsZOECBtxI62dfA43znc1jgvGAqCHwyuhIxL01tmW8FjiE8B1SI16
        OPs9CcW+uuQ/dypadOWhMYR/90RL/aqlZ6wODcJvhqNFnITmJJ7XwtpwsyU4CvwN
        K5QwLPdQjuOWA+mXVhSkVJo4mHTovOfR7CGk96HgE6eDbRN0X1qk3Pkrq/VF8pQT
        OJONbIyoehesaPICAEGHC0j5Bg/EaHCBrng/bIdRECtW2efZ2xyFbibREtSRNlMi
        1n+xMZrfPg7PtRMh8DZyo/ws7qTvnFb2LhkK8jUnSA/z/M7ouop+YWovw==
X-ME-Sender: <xms:YVyQZIdFVfU1ifvBkJF2yJGLMDIMojtLCXxL7zRjxuD-urh9jF5QmA>
    <xme:YVyQZKMAMIS9qMpc6cnYBE7GKJTlf5sP21vOIAsIsEzdKzPY7HojG_a5P8WxqL8fH
    XYMeT7MAc8HcCxq1Dw>
X-ME-Received: <xmr:YVyQZJgPp1Du-Jnn90ND94ouhLggLnmT4TV0Wik4xoVAaeKeC_MBm8QhSqCfzG4maz-IPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffhfekfedtjedthefhleetgeethfevtdehhfev
    ffdvteelveekledvtddtgefggfenucffohhmrghinheplhifnhdrnhgvthdpkhgvrhhnvg
    hlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:YVyQZN-fJ-SpoTbwk3U5tlvp6WhoQMRGzC4xwqxkCjupfx17nkd3UQ>
    <xmx:YVyQZEswWb7IJ8kU4KOYUN45jvcLHedSfbxDI9fZUnVohqPiVV7lSA>
    <xmx:YVyQZEGOZz0i1NX2N7Uvi0pVj0OZ0Khpmqel--lzRQnGUBP7I5SLsA>
    <xmx:YlyQZIfvOtfIuVxPltAevzrvlA_8Acb4Sa-7St6cijg_lyUmBplFBg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 09:47:12 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9BBE810DD6D; Mon, 19 Jun 2023 16:47:09 +0300 (+03)
Date:   Mon, 19 Jun 2023 16:47:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v7 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Message-ID: <20230619134709.6c4sgargh67xwc5g@box.shutemov.name>
References: <20230616044701.15888-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616044701.15888-1-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 15, 2023 at 09:46:59PM -0700, Dexuan Cui wrote:
> The two patches (which are based on the latest x86/tdx branch in the tip
> tree) are the x86/tdx part of the v6 patchset:
> https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/
> 
> The other patches of the v6 patchset needs more changes in preparation for
> the upcoming paravisor support, so let me post the x86/tdx part first.
> 
> This v7 patchset addressed Dave's comments on patch 1:
> see https://lwn.net/ml/linux-kernel/SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com/
> 
> Patch 2 is just a repost. There was a race between set_memory_encrypted()
> and load_unaligned_zeropad(), which has been fixed by the 3 patches of
> Kirill in the x86/tdx branch of the tip tree:
>   3f6819dd192e ("x86/mm: Allow guest.enc_status_change_prepare() to fail")
>   195edce08b63 ("x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()")
>   94142c9d1bdf ("x86/mm: Fix enc_status_change_finish_noop()")
>   (see https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx)
> 
> If you want to view the patchset on github, it is here:
> https://github.com/dcui/tdx/commits/decui/upstream-tip/x86/tdx/v7

JFYI, it won't apply to tip/master. Unaccepted memory changed the code you
patching.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
