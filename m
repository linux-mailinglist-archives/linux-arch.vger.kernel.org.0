Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311F135F8D8
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352657AbhDNQSM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345859AbhDNQSK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2021 12:18:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C7C061574
        for <linux-arch@vger.kernel.org>; Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w8so8063505plg.9
        for <linux-arch@vger.kernel.org>; Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0eL/B6Xsq6Q/24IYguuLfwVoh9qvE+Qw7MZOf5nGHyg=;
        b=DWKLnEjIRc6nqOLRuoo9K6bOLQMW5c1mqbVDL7yGhVs88fhUl8h/izys8YK3f/gwVM
         PcQzKMKIFq9o0hwsUhKISfLDewBl34wWHl1mNxtvbMhH9ULpfprQDggqRkhav/DB3fq5
         Lt6TuRqVyREjop1FfnrZ4OwusSTzbuxed+y0o4pqUcZLeuQPE7o9Q0ERP1T2859SlHBK
         swDXpNsO2sseabX97kJN/6O4FliaKLmz/0n5+zOfFOhIc71jVo20vJcnie48mgAzBh32
         YSPSVWZiitdeHf/qr6sagNpJv+45RDkOHNv90Ca9f1wMkoDLDoLK0Hka9u0ctg+akLmV
         r8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0eL/B6Xsq6Q/24IYguuLfwVoh9qvE+Qw7MZOf5nGHyg=;
        b=Fcji6r3dE5ff4Ocy4vuoeWdObLIgUzyA6HAGntls0uqBD2l8F2HpBaecPLqyPErTEl
         tQZkI3AynFlAv9Q2DWaE/K/QP20fI2tqgtnlMde+Ne0oD4j9+tCw9OoNT03/s/rgTEPV
         +hZ527FQJwQ46dCPA83Pkz/b7xjXOXy3r2csKQu9qH1hWqepwKdfDuXbhZFIlSo+M+wW
         VhyA56pEOA0oDbKG6gdBVSylYzJGGQBoWhiza8SUClMm9k5lRzGwgE/SzbcTXDDlzTDm
         GB3q5MvHnZhXcBMovlXrWOEXERbsp2e870x9VEtq9WosYd6tbB7EqE0KaqqXsPxGWzwj
         Zviw==
X-Gm-Message-State: AOAM531um0E1CUH4eK7UDAY181OUiXxr4GMuUmtwu+AIjlC0wSjoIafH
        MrcZM6MhQWyzfah8/gLoDYkxNg==
X-Google-Smtp-Source: ABdhPJx5Ic6DX2vQpbh90Yradu9W82hKhZ9FhXc7n7c05NjGIO6V9+vgFJUqzgqafzt2aOiNHdkPHQ==
X-Received: by 2002:a17:902:cec1:b029:eb:66ee:6da0 with SMTP id d1-20020a170902cec1b02900eb66ee6da0mr1001099plg.84.1618417068337;
        Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id r5sm5092591pjd.38.2021.04.14.09.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:17:48 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:17:38 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: Re: [Resend RFC PATCH V2 08/12] UIO/Hyper-V: Not load UIO HV driver
 in the isolation VM.
Message-ID: <20210414091738.3df4bed5@hermes.local>
In-Reply-To: <YHcOL+HlEoh5jPb8@kroah.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
        <20210414144945.3460554-9-ltykernel@gmail.com>
        <YHcOL+HlEoh5jPb8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 14 Apr 2021 17:45:51 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 14, 2021 at 10:49:41AM -0400, Tianyu Lan wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > 
> > UIO HV driver should not load in the isolation VM for security reason.
> > Return ENOTSUPP in the hv_uio_probe() in the isolation VM.
> > 
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

This is debatable, in isolation VM's shouldn't userspace take responsibility
to validate host communication. If that is an issue please participate with
the DPDK community (main user of this) to make sure netvsc userspace driver
has the required checks.

