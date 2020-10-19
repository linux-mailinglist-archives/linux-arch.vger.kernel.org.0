Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60289292A58
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 17:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgJSP0F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 11:26:05 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12118 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgJSP0E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2020 11:26:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8dafb00000>; Mon, 19 Oct 2020 08:24:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 15:25:59 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 15:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKP+uw1ITdvEQILBuaPFapvHGELoFV2OLZUU05Er/bM9bHbXuZCsxMQnHDMrPRVYxLEBkqJLM8qDO1n7XjWpCzn9Ocq+Bl06OSF1MIVD+Ilc0r/ULVyveW8XVG6fa42xEzN7/UpgxOVATPSCP5t+4vscDV20FwSURZpmSyFbPB6GcBf0VlcwNbI4kQ+uu2SircDb7t9W2L7h7JL6m5gsNBrKkOGjD2pneHWyDbsW6pQnnZMJdF3dBhZELIYF4mGNimgNyIB03v99Tocb6uDpEiTawfoOKYNu9jSkA0eHGk9B5+4PiRjgo7X5PyDnjP1h7BHaGjugFWxbHWa1Bj7Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAD4YhYy4w/iIVhyD1aD9WKwwuU5PyaeU+HlrQwSGwI=;
 b=EAheS2T1b/iPSxXsQ4rOS8ugxQLCgSei2Gk8+/XZrQrw1RIC06FJt3ub/qD116GLtoSVafL6vt7Mkj7Q7PHIRZKImB4Sj0GVTCO1ikWaR4qHsF8Qsp9Vtk5Ft1EvMQcn0T7A416uigeyNfEFa9sZqqwWkXPo0USwIqMBTG12D6egOqMxAKJuz0LmolVPLR6ZTwjWJal5MCdXMUymnyLl+aw5Fvvhs4ebUQEgmcCbgzhrPyIMEMPUfEADTaiv98vf4+6o9FpWdGOU6pPku5PYa5WJwoIuYs+8t4JYF0dW0pHFB54KJ0O/6rjMuz+z27EK/jhOApw9+AUaB5AWbUx9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 19 Oct
 2020 15:25:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 15:25:58 +0000
Date:   Mon, 19 Oct 2020 12:25:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rik van Riel <riel@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: AMD SME encrpytion and PCI BAR pages to user space
Message-ID: <20201019152556.GA560082@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Mon, 19 Oct 2020 15:25:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUX2q-002LsA-MN; Mon, 19 Oct 2020 12:25:56 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603121072; bh=EAD4YhYy4w/iIVhyD1aD9WKwwuU5PyaeU+HlrQwSGwI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=a9wjNQx/jaO6toRrCHDO33yzuLunPbL4estPTGud0blfahf3VGVP20iAccliJWmmL
         nUFtUyvw7dzs6hzTtRo8vH+7mjE75JM7GcPDWApHAojhIp6euvyKfyMpIQvjcizAJf
         zIwcuieZ+RjigrmYERMW0Ht/CQGaLx/iP/x/NiNbu07KZOHY3o7GzX2ikAMLQFDvGA
         DjYzUGn0fWRlfA7REZBc38O8dA5jq7vWq1O+kDtl9fpUYNEpnvHK7rvrbLDLSBN+1S
         rXdRg5gc+P0tFs/RhKfFbMDYlpg8Z8NcYWuEzdofha9d4iyZyAt8Ft3qIVwoJdjVhy
         SGgGdYyjHoh3A==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tom,

We've found a bug where systems that have the AMD SME turned on are
not able to run RDMA work loads. It seems the kernel is automatically
encrypting VMA's pointing at PCI BAR memory created by
io_remap_pfn_range() - adding a prot_decrypted() causes things to
start working.

To me this is surprising, before I go adding random prot_decrypted()
into the RDMA subsystem can you confirm this is actually how things
are expected to work?

Is RDMA missing something? I don't see anything special in VFIO for
instance and the two are very similar - does VFIO work with SME, eg
DPDK or something unrelated to virtualization?
     
Is there a reason not to just add prot_decrypted() to
io_remap_pfn_range()? Is there use cases where a caller actually wants
encrypted io memory?

I saw your original patch series edited a few drivers this way, but
not nearly enough. So I feel like I'm missing something.. Does vfio
work with SME? I couldn't find any sign of it calling prot_decrypted()
either?

(BTW, I don't have any AMD SME systems to test on here, I'm getting
 this bug report from deployed system, running a distro kernel)

Thanks,
Jason
