Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D319466B29
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 21:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349009AbhLBUwN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 15:52:13 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48249 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238643AbhLBUwN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 15:52:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 844045C01E1;
        Thu,  2 Dec 2021 15:48:49 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 15:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=V+oY0lvpRQ6EWyHSpKOwdyQZHvigeH/
        DqFU+688VfMY=; b=nb/nkksHB3a3v4m7IZp4fqN9v2xH5hSYXlFYTlHB+UWrVyH
        zTDvXiG5u/13oPUWZiI6qmf0PYrvqXZEvdl2SqEr4Y6QawYYzmnseHuysVT/lFIq
        V8MNlx4x00WGzc5fNSo+1GgM1UOD3mwX1IZ4Vp/T5pQc7VzQb6gZ6u0KrdEmDK9N
        xbsHXGFoSCie3plt1DgqtjMNV06JXlML19Zz0H/vf5Bq/klVz+0M1ohEHRNYDPeo
        IL7Cg8Y5P3pHdGfvgdXBSkSfMVKquO9L+7h7bg4QA3Zrg76+DszVT13+n7r5KNlb
        iriUINGYx8Ze31uCpxdzOO2Gv0t1NknSTRbPfHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V+oY0l
        vpRQ6EWyHSpKOwdyQZHvigeH/DqFU+688VfMY=; b=NQm5/SdfzT+EZ/AqkRR47a
        QX4yiM4sJjwLX4m6PvlVoMNjX+Uns4jeRpZTM7mMBWBlh3l8ufG/VWwDtu2brul0
        bRGYNECR1HwGvbO5xZYs5c8IJ5eyUpagJdfeekv2EHQbHJ1uDSHRjFbaXx/dDfwt
        TrV6iAZ8rAPqjZv3bVNtCx2Y9+EDrV11Ss/gUVNwcT5D6gla9+H9PwBjnLpL4vc6
        aljzCB68dMyH3Hg1PxjcBiJ85Eu61QapWuAGoJRsT1MRbqrh6ogBoZt7d6C6bmPS
        /VXkBMhkDj89rsmYNou+/aiC93ISbgkOKnA1tsiLHlqP3HuH8g2CZKkomwPlG1Qw
        ==
X-ME-Sender: <xms:MTGpYeEJPYWp_rHkqEacZFxYHsJd67PCuWde_SH5dYWqrSmdLSvCdg>
    <xme:MTGpYfV2PxMAfwkf12Wcl41xCYCZ32GQT7M7kVl9ac2lG76oEqZspgMjV4iJ4GJGN
    klk3u_Gtl_dcYLK3ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdgkrggt
    khcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtf
    frrghtthgvrhhnpefhuefhveeuffetfffgjeetgfekkeehfedtfeelgfehffffveehkeel
    fefgheffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:MTGpYYIcIk60IcYhPJipH82rcWZ_npxTlANWG_CTbh882idWQplhiQ>
    <xmx:MTGpYYFb3jITNU2wroc500kVkUXgtwzYSAT-u9F-RsjShajDz8ZIKQ>
    <xmx:MTGpYUWgEuT3sqp06vd3CA8jMwj1erEyitWGrie6-G1qgQ3qvVyqUQ>
    <xmx:MTGpYSyEIzBfPUqfSA9f-BvYW2l9jShFn38Fz-o3hMBGYUTAl4VOIg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 11E5C24A0077; Thu,  2 Dec 2021 15:48:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <1e3867cd-2c8b-4fe1-93a6-c6ae34120f6b@www.fastmail.com>
In-Reply-To: <913509.1638457313@warthog.procyon.org.uk>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
 <913509.1638457313@warthog.procyon.org.uk>
Date:   Thu, 02 Dec 2021 15:48:21 -0500
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Florian Weimer" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David Laight" <David.Laight@aculab.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 2, 2021, at 10:01 AM, David Howells via Libc-alpha wrote:
> Zack Weinberg <zack@owlfolio.org> wrote:
>> I could be persuaded otherwise with an example of a program for which
>> changing __s64 from 'long long' to 'long' would break *binary* backward
>> compatibility, or similarly for __u64.
>
> C++ could break.

That's too hypothetical to be actionable.  I would like to see a _specific program_, and I would like it to be one that already exists in the world and was not written as a test case for this hypothetical ABI break.

zw
