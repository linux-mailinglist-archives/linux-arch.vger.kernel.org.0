Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7C63314E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 01:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKVAYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 19:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiKVAY1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 19:24:27 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87092BEB42;
        Mon, 21 Nov 2022 16:24:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5100032009B5;
        Mon, 21 Nov 2022 19:24:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Nov 2022 19:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669076663; x=1669163063; bh=Je
        9S5pZ8EyiMqK1xbe6/5zr4qNlvKvr93DChjxiAVt4=; b=PrgW4w+9T36uTagTcG
        DjuC/DKB/qod8O6Ab5ag9KRtZ6RQtKP/iuauByNe51gZ28Im2l2Sgx4MtQr4W0QU
        6c9JYOMzl1zQA0hT8J6sNApeVInfSRACqKgpxF6nNmexDm3R9CtLlcfUYmkuku2+
        62iXPO01NV17lZiO68Lv7t9KpXe+/jOoKhdC/0ce/1HgMlbF+II7pBfYi19XlZLb
        S+gotbNeB6q38ZT1E3+gVD39RpJeuQkbSfnw5JIYXlbZpinnFrhd74zAasVFqF/O
        w6gnVR2bwl0W+ReRnd8v+p4ylyIp+ZUl6M4VWSH3Z+n3IJM3NacgoGgI9h5gY635
        OR9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669076663; x=1669163063; bh=Je9S5pZ8EyiMqK1xbe6/5zr4qNlv
        Kvr93DChjxiAVt4=; b=bCORFpPvnGwyahVwCiYhm+8wPJG9H/WawgxDZU6Uf9qQ
        KfL+5SLRXQ9emqLalBhYvrVbKiHv6Fhf3rg4IzE2RTL2yHWw8oDh+7bLA5aC8TAf
        OTwTUqReBTozxETh7x4jHlIAbPYhfRQ3b2/4OzNFQyTiTL40kGYf1rgK7NInN3SZ
        5c1C5Y89Rc/ZiDgat75rMWctdksayTEeMsVYCbPrJsEt8k1MtOSJCoAXYTJBRXLs
        WtFwlSo8gvMAY2fOU16DA1jxe8KuKntX5gzdHC4yeoSUMv72C2xIKvUkZ8892KHz
        RQYD9LDAMkVggVOmy0ckCTU5n+0EyHkTr89cBz0eyg==
X-ME-Sender: <xms:txZ8Y6rOINf9Iu_Fb0mqmBuJpwiSITipXIGsstg6SRqGCS0-9Q-UsA>
    <xme:txZ8Y4rWUkssecG44BQoEz47swOHK52mowVHyzYVDv7Yk_AOiQRz0OhakY5YxyIdW
    dUA1ddLBJiNoMaavpo>
X-ME-Received: <xmr:txZ8Y_OsnenBAjXRxDiRcpIidUwjd8eSQPDk4dsLeH_5T3XRSfCRYPiGafG8aKymsEFIKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheejgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:txZ8Y55hbJDgu8qyI8jfliGsdlH637Dw3TKDt1S0QpLzc8HmdgD2WA>
    <xmx:txZ8Y55IxRuShIiK28Dj3rgl_BN-VTiLLVWXWE65TJkjKghQ5iDvKg>
    <xmx:txZ8Y5h7zIjLVBTVQreLo8y0UGay1WyZJkO027Jt9qsdqEyY01csnA>
    <xmx:txZ8Y4LTB_Q6VYtprrdunhn5sZZM0TzRsoE1dQw2DrTqIU6bQ77OUA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 19:24:23 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A7279109A30; Tue, 22 Nov 2022 03:24:21 +0300 (+03)
Date:   Tue, 22 Nov 2022 03:24:21 +0300
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20221122002421.qg4h47cjoc2birvb@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-4-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121195151.21812-4-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022 at 11:51:48AM -0800, Dexuan Cui wrote:
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with the
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.

Why do you use vmalloc here in the first place?

Will you also adjust direct mapping to have shared bit set?

If not, we will have problems with load_unaligned_zeropad() when it will
access shared pages via non-shared mapping.

If direct mapping is adjusted, we will get direct mapping fragmentation.

Maybe tap into swiotlb buffer using DMA API?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
