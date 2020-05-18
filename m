Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8F1D7E7C
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgERQ3e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 12:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERQ3d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 12:29:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DBFC207ED;
        Mon, 18 May 2020 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589819373;
        bh=eVo1KrushuoOqD/i/GVRln1MQqKMazgpzcLc/PqbMpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jbc+Paz+d0TC7ChNglvu70jfvtkFw71keT5aS+1OakptMbn0rhDdw+umyKIhB7eC8
         YfsX2EIfy8SURvjCjkwa2JlW0+T0OSbO2SV2L48/knAzTIkb2GXmfre9rAHTWQfz41
         Ffk66dnltLuFH198O8catZPKYXcHS06O6Lw9ODM8=
Date:   Mon, 18 May 2020 17:29:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 14/14] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Message-ID: <20200518162928.GP32394@willie-the-truck>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-15-git-send-email-Dave.Martin@arm.com>
 <20200513072530.GA18196@willie-the-truck>
 <20200513143653.GQ21779@arm.com>
 <20200513210022.GA28594@willie-the-truck>
 <20200518161128.GB21779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518161128.GB21779@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 05:11:28PM +0100, Dave Martin wrote:
> How about summarising the key error cases here, and just putting a cross-
> reference in the ERRORS section rather than trying to describe them
> there?  I really don't want to duplicate this stuff -- that will get
> unmaintanable, fast (if it hasn't already).

Makes sense to me.

Will
