Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0441D76FB
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 13:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERL0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 07:26:02 -0400
Received: from foss.arm.com ([217.140.110.172]:38446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERL0C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 07:26:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06174106F;
        Mon, 18 May 2020 04:26:02 -0700 (PDT)
Received: from [10.57.27.185] (unknown [10.57.27.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194B13F52E;
        Mon, 18 May 2020 04:25:59 -0700 (PDT)
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable MTE
 support
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
Date:   Mon, 18 May 2020 12:26:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200515171612.1020-25-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/15/20 6:16 PM, Catalin Marinas wrote:
> For performance analysis it may be desirable to disable MTE altogether
> via an early param. Introduce arm64.mte_disable and, if true, filter out
> the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> user.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     New in v4.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2a93c8679e8..7436e7462b85 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -373,6 +373,10 @@
>  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
>  			Format: <io>,<irq>,<nodeID>
>  
> +	arm64.mte_disable=
> +			[ARM64] Disable Linux support for the Memory
> +			Tagging Extension (both user and in-kernel).
> +

Should it really to take parameter (on/off/true/false)? It may lead to expectation
that arm64.mte_disable=false should enable MT and, yes, double negatives make it
look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?

Cheers
Vladimir
