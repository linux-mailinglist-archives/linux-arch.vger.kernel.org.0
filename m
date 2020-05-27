Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E970C1E356E
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 04:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgE0CRe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 22:17:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61628 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgE0CRe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 May 2020 22:17:34 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 22:17:31 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590545853; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Bmk5WkxY5L5x6WBMTF6uxk/H1gCBb/eUTlTTCX/Pjmw=; b=Fk/T8J31FrhT2w8JmhtKf9snKPGB9fTwSe6dVHQKJwH1wfxbDtE7mVnzuysSfRlobdaSmQbw
 3VxexfTEnxeiDXonlmZ+TqkwIEfbpjz851sK0gzY/ExZHlbcHNbzL1xH7Ra7MtZtArIGhE8x
 XKnG3dnydNQg0TjHckt9DLflBRA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ecdcc76cb045869337fdaed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 02:12:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29FB9C43387; Wed, 27 May 2020 02:12:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pdaly-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pdaly)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAB9AC433C9;
        Wed, 27 May 2020 02:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAB9AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pdaly@codeaurora.org
Date:   Tue, 26 May 2020 19:11:53 -0700
From:   Patrick Daly <pdaly@codeaurora.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200527021153.GA24439@pdaly-linux.qualcomm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
 <20200522055710.GA25791@pdaly-linux.qualcomm.com>
 <20200522103714.GA26492@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522103714.GA26492@gaia>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 11:37:15AM +0100, Catalin Marinas wrote:
> Hi Patrick,
> 
> On Thu, May 21, 2020 at 10:57:10PM -0700, Patrick Daly wrote:
> > On Mon, May 18, 2020 at 06:20:55PM +0100, Catalin Marinas wrote:
> > > On Mon, May 18, 2020 at 12:31:03PM +0100, Will Deacon wrote:
> > > > On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> > > > > On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > index f2a93c8679e8..7436e7462b85 100644
> > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > @@ -373,6 +373,10 @@
> > > > > >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> > > > > >  			Format: <io>,<irq>,<nodeID>
> > > > > >  
> > > > > > +	arm64.mte_disable=
> > > > > > +			[ARM64] Disable Linux support for the Memory
> > > > > > +			Tagging Extension (both user and in-kernel).
> > > > > > +
> > > > > 
> > > > > Should it really to take parameter (on/off/true/false)? It may lead to expectation
> > > > > that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> > > > > look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?
> > > > 
> > > > I don't think "performance analysis" is a good justification for this
> > > > parameter tbh. We don't tend to add these options for other architectural
> > > > features, and I don't see why MTE is any different in this regard.
> > > 
> > > There is an expectation of performance impact with MTE enabled,
> > > especially if it's running in synchronous mode. For the in-kernel MTE,
> > > we could add a parameter which sets sync vs async at boot time rather
> > > than a big disable knob. It won't affect user space however.
> > > 
> > > The other 'justification' is if your hardware has weird unexpected
> > > behaviour but I'd like this handled via errata workarounds.
> > > 
> > > I'll let the people who asked for this to chip in ;). I agree with you
> > > that we rarely add these (and I rejected a similar option a few weeks
> > > ago on the AMU patchset).
> > 
> > We've been looking into other ways this on/off behavior could be achieved.
> 
> The actual question here is what the on/off behaviour is needed for. We
> can figure out the best mechanism for this once we know what we want to
> achieve. My wild guess above was performance analysis but that can be
> toggled by either kernel boot parameter or run-time sysctl (or just the
> Kconfig option).
> 
> If it is about forcing user space not to use MTE, we may look into some
> other sysctl controls (we already have one for the tagged address ABI).

We want to allow the end user to be able to easily "opt out" of MTE in favour
of better power, perf and battery life.

In terms of deciding policy, a sysctl is much more accessible than
reompiling with CONFIG_MTE=n, or replacing userspace libraries with
equivalents which don't use PROT_MTE.

--Patrick

> 
> If it is for working around hardware not supporting MTE (i.e. no
> allocation tag storage), this should be handled differently, not by
> kernel parameter.
> 
> > The "arm,armv8.5-memtag" DT flag already provides what we want - meaning
> > that this flag could be removed if the system did not support MTE.
> > 
> > I did see your remark on "arm64: mte: Check the DT memory nodes for MTE support"
> > questioning whether it was the right approach - is this still the case?
> 
> My plan is to remove the DT patch altogether _if_ I get confirmation
> from the CPU designers. The idea is that if ID_AA64PFR1_EL1.MTE > 1,
> Linux can assume system-wide MTE support. If an MTE-capable CPU is
> deployed in an SoC without tag storage, a tie-off should change the ID
> field to 1 (or 0). If we do find hardware with an ID field > 1 and no
> tag storage, it will be handled as an SoC erratum in the kernel,
> probably tied to the new SoC Id advertised by firmware (Sudeep had some
> patches recently).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
