Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1613B4AEC
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 01:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFYXdg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 19:33:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:40509 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhFYXdf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Jun 2021 19:33:35 -0400
IronPort-SDR: pKAMUGstilS92Fa3/M2bs29zeobz/2en4wpJ42E8ebejmuc7v6sXlxCCsDt7WP9P/YT/pxM1FI
 BAmc/1lv0xvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="271612195"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="271612195"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 16:31:13 -0700
IronPort-SDR: KdN4vs8+bgdyV534hmve1fq/tVteJ+UOPaeCL9MSbMDN0PqO6HEIWprSM4iVrVMXiKNLf+1w+F
 EBxQcKVM+j0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="407529066"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2021 16:31:12 -0700
Received: from tjmaciei-mobl1.localnet (10.212.209.179) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 26 Jun 2021 00:31:10 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     <fweimer@redhat.com>
CC:     <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Fri, 25 Jun 2021 16:31:06 -0700
Message-ID: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <87tulo39ms.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.209.179]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23 Jun 2021 17:04:27 +0200, Florian Weimer wrote:
> We have an interface in glibc to query CPU features:
> X86-specific Facilities
> <https://www.gnu.org/software/libc/manual/html_node/X86.html>
>
> CPU_FEATURE_USABLE all preconditions for a feature are met,
> HAS_CPU_FEATURE means it's in silicon but possibly dormant.
> CPU_FEATURE_USABLE is supposed to look at XCR0, AT_HWCAP2 etc. before
> enabling the relevant bit (so it cannot pass through any unknown bits).

It's a nice initiative, but it doesn't help library and applications that need 
to be either cross-platform or backwards compatible.

The first problem is the cross-platformness need. Because we library and 
application developers need to support other OSes, we'll need to deploy our 
own CPUID-based detection. It's far better to use common code everywhere, 
where one developer working on Linux can fix bugs in FreeBSD, macOS or Windows 
or any of the permutations. Every platform-specific deviation adds to 
maintenance requirements and is a source of potential latent bugs, now or in 
the future due to refactoring. That is why doing everything in the form of 
instructions would be far better and easier, rather than system calls.

[Unless said system calls were standardised and actually deployed. Making this 
a cross-platform library that is not part of libc would be a major step in 
that direction]

The second problem is going to be backwards compatibility. Applications and 
libraries may want to ship precompiled binaries that make use of the new CPU 
features, whether they are open source or not. It comes as no surprise to 
anyone that we CPU makers will have made software that use those features and 
want to have it ready on Day 1 of the HW being available for the market (if 
we're doing our jobs right). That often involves precompiling because everyone 
who installed their compilers more than one year ago will not have the 
necessary tools to build. That runs counter to the need to use a libc 
interface that didn't exist until recently.

And by "recently", I mean "anything since the glibc that came with Red Hat 
Enterprise Linux 7" (2.17).

So no, application and library developers will not use libc functions they 
don't need to, especially if it adds to their problems, unless there's no way 
around it.

> Previously kernel developers have expressed dismay that we didn't
> coordinate the interface with them.  This is why I want raise this now.

You also need to coordinate with your users.

A platform-specific API to solve a problem that is already solved is "knock 
yourself out, we're not going to use this." So my first suggestion is to 
remove the "platform-specific" part and make this a cross-platform solution.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering


