Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898AB508DC0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380707AbiDTQxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351569AbiDTQxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 12:53:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FCB2E09B
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:51:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b7so2325924plh.2
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W+pAHZ/PIPE0DKbOw9kKGPFs28GbCHt7IPyK4IQ+geg=;
        b=iv48MygQl8ASnZAdOhP8w9xfqCrxsUYO2woNAOjT2gnh731P0cx/zggDl0yiVx+Y3X
         GWqrpBglTZvDUAKUvwQfgIzp5kqefDaGzR8p22S1jBuEkyNIsbJpkVWmHwEvfpMRgXpt
         9i35fae3ZuflrzPpBJoUzl5+AdfspcduaRbiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+pAHZ/PIPE0DKbOw9kKGPFs28GbCHt7IPyK4IQ+geg=;
        b=S1zrTml/MVGlGmVQSOjP1Un2DyuTYQhrMQFFzriPsnuB+9/zqLFjLlgsbzD9sr1Ltd
         phKCpo8Y9kDcf0VZBKaw6xExJa1b7ybama1M/ljvT7LTI2pACqZRjPN/VZe+XWChJnTz
         R7hUW1pDzZj6IFyJvvXv1tLKPRYn3EsJXz811FLfryskXZiLQS1NfDsr6juIFcREfAjq
         F1Xmr9wZc4fQjfT2JSEjAdfiF053XcuXC2D1esDGS9Oj8pPZUfPcN98aSo1EtEk/p9Is
         bPD9FnPh5FaaxeYIMl5iON8rCaez3iSOXh5SrIpZkmXOAf3MitFjpfrctSWIREjwHsRd
         Yxeg==
X-Gm-Message-State: AOAM5322VX4spoU74FKd9peFst1DMBerNhVVaI3NF54bO7KX2yZNeQW4
        C92s/QZq91+eO/bpD+mT/7bdnw==
X-Google-Smtp-Source: ABdhPJyGpUSxKI3QmXGliTSRS9PFUS/7qr8Bl7Zp7Gb7+JaxuDL7MsUE2PzfC7EPLyEG7NNEjIzScQ==
X-Received: by 2002:a17:902:744a:b0:158:9b85:192e with SMTP id e10-20020a170902744a00b001589b85192emr21525578plt.96.1650473466332;
        Wed, 20 Apr 2022 09:51:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm240425pjf.40.2022.04.20.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:51:06 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:51:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, szabolcs.nagy@arm.com,
        yu-cheng.yu@intel.com, ebiederm@xmission.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <202204200950.C70BFB3@keescook>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck>
 <Yl/ZCvPB2Qx98+OG@arm.com>
 <Yl/1KertC3/UtwR4@sirena.org.uk>
 <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 20, 2022 at 08:39:14AM -0500, Jeremy Linton wrote:
> On 4/20/22 06:57, Mark Brown wrote:
> > On Wed, Apr 20, 2022 at 10:57:30AM +0100, Catalin Marinas wrote:
> > > On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:
> > 
> > > > Kees, please can you drop this series while Catalin's alternative solution
> > > > is under discussion (his Reviewed-by preceded the other patches)?
> > 
> > > > https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com
> > 
> > > > Both series expose new behaviours to userspace and we don't need both.
> > 
> > > I agree. Even though the patches have my reviewed-by, I think we should
> > > postpone them until we figure out a better W^X solution that does not
> > > affect BTI (and if we can't, we revisit these patches).
> > 
> > Indeed.  I had been expecting this to follow the pattern of the previous
> > nine months or so and be mostly ignored for the time being while
> > Catalin's new series goes forward.  Now that it's applied it might be
> > worth keeping the first patch still in case someone else needs it but
> > the second patch can probably wait.
> > 
> > > Arguably, the two approaches are complementary but the way this series
> > > turned out is for the BTI on main executable to be default off. I have a
> > > worry that the feature won't get used, so we just carry unnecessary code
> > > in the kernel. Jeremy also found this approach less than ideal:
> > 
> > > https://lore.kernel.org/r/59fc8a58-5013-606b-f544-8277cda18e50@arm.com
> > 
> > I'm not sure there was a fundamental concern with the approach there but
> > rather some pushback on the instance on turning it off by default.
> 
> Right, this one seems to have the smallest impact on systemd as it exists
> today. I would have expected the default to be on, because IMHO this set
> corrects what at first glance just looks like a small oversight. I find the
> ABI questions a bit theoretical, given that this should only affect
> environments that don't exist outside of labs/development orgs at this point
> (aka systemd services on HW that implements BTI).
> 
> 
> The other approach works, and if the systemd folks are on board with it also
> should solve the underlying problem, but it creates a bit of a compatibility
> problem with existing containers/etc that might exist today (although
> running systemd/services in a container is itself a discussion).
> 
> So, frankly, I don't see why they aren't complementary. This fixes a bug we
> have today, the other set creates a generic mechanism for the future.

Okay, well, how about I drop this for now, and I'll Ack the ELF loader
changes so this can go through the arm64 tree if there is consensus.

-- 
Kees Cook
