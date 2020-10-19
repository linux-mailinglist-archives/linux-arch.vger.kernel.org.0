Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD23292C0F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgJSRAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 13:00:39 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3503 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgJSRAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2020 13:00:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8dc6070005>; Mon, 19 Oct 2020 09:59:51 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 17:00:32 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 17:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao5g7wQ5l4KdEVVjatUuiUzF1HR9QQGQEdAULXVahcoU1VMPDUvLlSDogC49gjQJMGySQhXO4tvG/gxk3mdiq5Rme61SZ/aw4l3EanmjbA3MFO4AlCoHcacWPciiSYVkmVtg74n+dRo7LInfgi5esyooXotBqustwfa6HX63oA1yMiOPJcZQmc+a6ZehY+uDxuuQdKGjyV8OU1e9W8B+wC6KQqVLgrwlPk+7bqNchctyJj7moEEcrQ+fxeLddYcsv74y5nbndyH10TJnmUIkFN7PU8ksIlgQ7zmB51LH435T4gH34QvY9LkYFM2JKnmg5DsIpfW3/GKuAKbiSHfzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdcSjjWZePS0hH/ubWLT74o1FPXKYWW71rD9/WjGt00=;
 b=SmowLsGN0KAXz8sVtXfP4ihgWSt4t0gPYutDeOU2QiSyI8TOSUp2VvyV71pCEsZWxbpZmk9CVg2HyHU6eEpSTuKoFEmtYW5EUFJ9tiuRK1CYxz3xO3K86yLS1hnScud9+1+2PAZUce9T/x5VCxDJuD+1Kse3zYbxX9/v5hY9ZCabrOq2nafXaggvN+Fl/UnsMSpMUaeFP4lZHUOyQiQqUDBB+UAaaIbM5pYlj147v9Vb22AmkpsaXTAPaWeCNo0ThBOKzkECcs6WBMillRRfutR2P3XQodQKcQrZezLTWeICin6nVns4UntoBO4UHkkvF3CtknfSDQ4lfkvuOaWwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 17:00:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 17:00:31 +0000
Date:   Mon, 19 Oct 2020 14:00:29 -0300
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
Subject: Re: AMD SME encrpytion and PCI BAR pages to user space
Message-ID: <20201019170029.GU6219@nvidia.com>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 17:00:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUYWL-002OXy-Ml; Mon, 19 Oct 2020 14:00:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603126791; bh=pdcSjjWZePS0hH/ubWLT74o1FPXKYWW71rD9/WjGt00=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=lCn/SDs70aiXrQpWqP/anl+ViQ+NtikaVW6bkKMcpy+6HB+KCpnl84LqvuulOO6iZ
         wfS1BMN1l7eOSf/3JujExDLUZiqfrSyjQhSpQcUsMhMEh0dqWQwF2Ip8gaqnhOarkI
         ti5jdkn6JuJSw92F3krnj3df63pzVw8NgzrpsU7rg3XIqnDLbob7DoP642Bkb2hO5H
         7/GvBqm2PBKX2PhMkkZEovBLhDDySpmfzo6YcWJM3QeuiGe6NoUCca8Cd1+czhKw2z
         tTyiW9JRfpsPlCVramEfX758UhYYYjgcobLOqma1CTxJ3m93GQBuJewyrdadh6rQ9O
         AdHMVtrOm7PSA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 19, 2020 at 11:36:16AM -0500, Tom Lendacky wrote:

> > Is RDMA missing something? I don't see anything special in VFIO for
> > instance and the two are very similar - does VFIO work with SME, eg
> > DPDK or something unrelated to virtualization?
> 
> If user space is mapping un-encrypted memory, then, yes, it would seem
> that there is a gap in the support where the pgprot_decrypted() would be
> needed in order to override the protection map.

It isn't "memory" it is PCI BAR pages, eg memory mapped IO

> > Is there a reason not to just add prot_decrypted() to
> > io_remap_pfn_range()? Is there use cases where a caller actually wants
> > encrypted io memory?
> 
> As long as you never have physical memory / ram being mapped in this path,
> it seems that applying pgprot_decrypted() would be ok.

I think the word 'io' implies this is the case..

Let me make a patch for this avenue then, I think it is not OK to add
pgprot_decrypted to every driver.. We already have the special
distinction with io and non-io remap, that seems better.

> > I saw your original patch series edited a few drivers this way, but
> > not nearly enough. So I feel like I'm missing something.. Does vfio
> > work with SME? I couldn't find any sign of it calling prot_decrypted()
> > either?
> 
> I haven't tested SME with VFIO/DPDK.

Hum, I assume it is broken also. Actually quite a swath of drivers
and devices will be broken under this :\

Jason
