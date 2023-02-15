Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72AD698160
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBOQw6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 11:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBOQw5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 11:52:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D69EF6;
        Wed, 15 Feb 2023 08:52:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C2FBD5C014E;
        Wed, 15 Feb 2023 11:52:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Feb 2023 11:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676479973; x=1676566373; bh=MU
        YJfLXfooeBFGGF3EXMWlWsGrKUUKTiU4nInOcEtlI=; b=ZwuPWG1oKFjOr//jVg
        Fo6uuun9L2lzzHC5PZlF52vO9UID0jfPgkvAXaMhIXoDtsj5K9mDK5xQNEQ3U7uJ
        x47S3W9e3TkoVIaL3hN8+1R6bFhO+XfCmDx5i41+anERXTWfMP5cC9OWqu/9ooY+
        bdDwBRxgtMTf9akr3rgWtk1Ez1CUnDqcNr4I8GhwPcboCxcjEky4amztvrhPwcxV
        jA26TdmAp8Xt4oZ9cqh7b6l2vrqgU3ZylipwV1TPXqSJv45XqFaXju5mACufMu1U
        K0iSUQCNwTBfnN2sOHuhNIbelgFTWjzbmR+hiiAuGfW66WDH6twOiL7hBwmKoBA9
        M50w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676479973; x=1676566373; bh=MUYJfLXfooeBFGGF3EXMWlWsGrKU
        UKTiU4nInOcEtlI=; b=aG7mWwluoArDkH7iaHltpfvufobwAFCwdYIT5EZYfxon
        seWgh6tFdNjNtL9SfnZz9YqTcQQcvXQ4RJmppfJBcfAG+BbN75sKx/oRWsuVV4zH
        QGJnm2JP4VD1/tkyeo/Y1HULAltKnfZGms3dWyzEN/DK2H8vHURG9QNNhZ57JhXy
        GZZh2dVnxIbNg6PnyjDz8qzZD/edHtRTt9+d2COpjKSwMhscjokfjZj5hCoKiWkn
        Phrcqg3i8f1lKdfZun2RukTH1muNO7KP4uYt77jcxNY2bbWhFpvKIrcUBzhvZO4z
        hbXW+9DxRct0jjXXSnDVgOTwIReG2WgzEYV4bRGWUQ==
X-ME-Sender: <xms:5A3tYyK4B4z3A28mEmPI9Gqhv13iJCzOAoiXrIucDQ42-flCCS8tQQ>
    <xme:5A3tY6IOBhIBPg9RrMkq7ZTNxS0X_USmyxGIbYl6U3R8UF5m1fW6lA_hs8bDvPKxN
    vT7UyNh3BROBBq2w4c>
X-ME-Received: <xmr:5A3tYysfcg5_5AGUT7aDxnOY3rc7WG9ttZeZQpgMPAxX8-J15e7D9eJdAjPnzbXzfzAr8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:5A3tY3ZTH_kaKus3X_goK-D52J5S-QOYeezXEMPI_g_s7_VrjdoW8Q>
    <xmx:5A3tY5ZRXrimGRjIF7P0iPwHDXcYAA-XQcMpx84WjTuEBxDNag_6iA>
    <xmx:5A3tYzAdpAiQ74xZIaDv_eBxjL5gSlgEB13baPN7M6DeDQ67WXd29w>
    <xmx:5Q3tY2TM64l9gfijDlri1UtJJLXIWD_-qDIesLRRB8KhmErqG4rk3w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 11:52:52 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D4F3710CF03; Wed, 15 Feb 2023 19:52:48 +0300 (+03)
Date:   Wed, 15 Feb 2023 19:52:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
Subject: Re: [PATCH v3 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Message-ID: <20230215165248.ivnmo77vfqzixtjm@box.shutemov.name>
References: <20230206192419.24525-1-decui@microsoft.com>
 <20230206192419.24525-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206192419.24525-2-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 11:24:14AM -0800, Dexuan Cui wrote:
> GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
> error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
> operation for the pages in the region starting at the GPA specified
> in R11.
> 
> When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
> when hyperv_init() -> swiotlb_update_mem_attributes() ->
> set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Looks good to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
