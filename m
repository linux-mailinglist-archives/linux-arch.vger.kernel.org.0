Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61264789B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLHWIs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 17:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLHWIM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 17:08:12 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422A79C35;
        Thu,  8 Dec 2022 14:07:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EAC25C00DE;
        Thu,  8 Dec 2022 17:07:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Dec 2022 17:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670537228; x=1670623628; bh=Dy
        B+B8MtQb2fOnIlvIxqzSDOKodU/cQnRbndcmgRAbg=; b=HNhMVbw5qWol0S3yls
        x35r7e29BknDwgYpIClfd43/NXUEp90AJAe4hAJ7e0McdPHPd/QhVo2Wx7bxaMb2
        ouYEJY07izoVGMVWfeqUBy8EPceiAf1uZbzR1Qh/SXkFwakkJzhiB5bAi2wXuwXD
        BxPXOzj+H083LY3VOyGC7UmQpL5swywAqltM6tyB99rXam+R3lnkRZX8mEfpN4Lr
        +HtTj+xqpVO8AXilvXE06V0xokCp59cnTxGClE8aQPgZF/Mc6TV3nttVxYMyyOFg
        5Z5+mmNfD2SNbeZWlq3gYNJxk2vDWx4bUrWs/GOWdUrmqt3o+l+L2KMv8lvP+qWq
        MeZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670537228; x=1670623628; bh=DyB+B8MtQb2fOnIlvIxqzSDOKodU
        /cQnRbndcmgRAbg=; b=h2emNTSpOXXr+KNTvpkiPqusLJXQuK3wBz+5OWsBa6P/
        a4drG90UXraKh6bZBvXRQNqJN+vv5FW8Cu0HclocdQmFLpDjLJYRB68T5UQxYAob
        EGylAGFBpZWdADv0jnFl6HI+ttQxFilCDyy36INTB9icyv99z4+fdqHOWQiq1HGO
        AST2L4g7kDr1U9bHRBVW6CG/qvS67MmPVhGIyjrh7SRfX2WraRbJnsDcsbF4ycEa
        1+OqA4WZhVIH51EFIHvFOvqBGfjUWzqYu8Zl1x6/u+rm8ra6UyP8QC7LAlfkOgBX
        Sy2Nt+B0waqIa5x20I88ZhiZ5OoM6GeBcHJV9LVf8w==
X-ME-Sender: <xms:C2CSY7dgoqyuM9irjTL5kAkn37nkxoba95wFvXWf0Kpra_f9yHTSAg>
    <xme:C2CSYxO0sYYAQJHzhGa2QXKeHhWwsF1Ya6wCrsERb46H9aKW1ptopTc66wgZQuCjN
    ExwaoitAgnkxJdJykI>
X-ME-Received: <xmr:C2CSY0gWV3TWaCWJGY9gCfcXibdMbwfoJrsmhdzP2QLUWKNBX3fHHE26ZkCqPgYTFw-2nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:C2CSY8-YXAaGhoO0xtB-Nue_MU9P7YldgjXMGe1NXqB5x9mEddEZIQ>
    <xmx:C2CSY3vOzoNg0tVSYm8TF2_I0TY8MIW9_7JFLix-8dfqJiaPzJZZ6g>
    <xmx:C2CSY7EI23D16QxOvuK6G1_V9nnHeoU9dxxx5MpI2kDGsPf8fBYcdA>
    <xmx:DGCSY2-8LiZNMh-nG0Zhu-WWzdOwl8nZvS3IIGs6nACC-woHdASDFw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 17:07:07 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DE081109CB7; Fri,  9 Dec 2022 01:07:05 +0300 (+03)
Date:   Fri, 9 Dec 2022 01:07:05 +0300
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Message-ID: <20221208220705.gog2lmlooio4act3@box.shutemov.name>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-5-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207003325.21503-5-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 06, 2022 at 04:33:23PM -0800, Dexuan Cui wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> So far __tdx_hypercall() only handles six arguments for VMCALL.
> Expanding it to six more register would allow to cover more use-cases.
> 
> Using RDI and RSI as VMCALL arguments requires more register shuffling.
> RAX is used to hold tdx_hypercall_args pointer and RBP stores flags.
> 
> While there, fix typo in the comment on panic branch.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Dexuan Cui <decui@microsoft.com>

Since you submit the patch you need to add your Signed-off-by.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
