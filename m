Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5F1DDF8E
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEVF5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 01:57:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27416 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgEVF5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 01:57:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590127038; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=wxYTDj1XX4heEChza4HPVrwYprGUE8YzD1J8/xWHYNM=; b=M95QoZxrWAvjTm0yi9frDH97ict/D7FIHlK05dIc0PEzPF+e9bfWDBoTXDHzA4xYwebdZ8xM
 x6MFM0h9W1pT/LrhJXv8f5v8v9haXcdSFpnkL6sTM1UC2voT9jJFZs9sVgqxJWKUvC+Dn5XA
 L2KR2mfTTh0ezPYucE0oygc8T/g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ec769bd7c3c9cd0697052b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 05:57:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7DEB1C43387; Fri, 22 May 2020 05:57:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pdaly-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pdaly)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32E51C433C6;
        Fri, 22 May 2020 05:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32E51C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pdaly@codeaurora.org
Date:   Thu, 21 May 2020 22:57:10 -0700
From:   Patrick Daly <pdaly@codeaurora.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200522055710.GA25791@pdaly-linux.qualcomm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518172054.GL9862@gaia>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 06:20:55PM +0100, Catalin Marinas wrote:
> On Mon, May 18, 2020 at 12:31:03PM +0100, Will Deacon wrote:
> > On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> > > On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > > > For performance analysis it may be desirable to disable MTE altogether
> > > > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > > > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > > > user.
> > > > 
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > ---
> > > > 
> > > > Notes:
> > > >     New in v4.
> > > > 
> > > >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> > > >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> > > >  2 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index f2a93c8679e8..7436e7462b85 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -373,6 +373,10 @@
> > > >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> > > >  			Format: <io>,<irq>,<nodeID>
> > > >  
> > > > +	arm64.mte_disable=
> > > > +			[ARM64] Disable Linux support for the Memory
> > > > +			Tagging Extension (both user and in-kernel).
> > > > +
> > > 
> > > Should it really to take parameter (on/off/true/false)? It may lead to expectation
> > > that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> > > look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?
> > 
> > I don't think "performance analysis" is a good justification for this
> > parameter tbh. We don't tend to add these options for other architectural
> > features, and I don't see why MTE is any different in this regard.
> 
> There is an expectation of performance impact with MTE enabled,
> especially if it's running in synchronous mode. For the in-kernel MTE,
> we could add a parameter which sets sync vs async at boot time rather
> than a big disable knob. It won't affect user space however.
> 
> The other 'justification' is if your hardware has weird unexpected
> behaviour but I'd like this handled via errata workarounds.
> 
> I'll let the people who asked for this to chip in ;). I agree with you
> that we rarely add these (and I rejected a similar option a few weeks
> ago on the AMU patchset).

We've been looking into other ways this on/off behavior could be achieved.
The "arm,armv8.5-memtag" DT flag already provides what we want - meaning
that this flag could be removed if the system did not support MTE.

I did see your remark on "arm64: mte: Check the DT memory nodes for MTE support"
questioning whether it was the right approach - is this still the case?
--Patrick

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
