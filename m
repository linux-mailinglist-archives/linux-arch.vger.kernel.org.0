Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1096E2AD035
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 08:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKJHEb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 02:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJHEa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 02:04:30 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C8D2068D;
        Tue, 10 Nov 2020 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604991870;
        bh=GodH8mXkwS3BpyGB+OPflXphx7SbHt5K0HWedDmjuZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAFy/2Z6HjpCOsMXkc3yHhuNjvyxjE9HbjninumZe/AiFP5oHFKN/RkSQN6qCvBPO
         DQWSZ8NmuftDyZPLsgjrwHYTbIwz4l7/wcbZHi1fIPYvUyQYsRv1mf4fGRE506RAJH
         AKM5kFEtLEh+yOS/OxBALcVH8hTV8BhAWYlPWdk0=
Date:   Tue, 10 Nov 2020 08:04:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] arm64: Advertise CPUs capable of running 32-bit
 applications in sysfs
Message-ID: <X6o7euVw0QlysIPV@kroah.com>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109213023.15092-6-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 09, 2020 at 09:30:21PM +0000, Will Deacon wrote:
> Since 32-bit applications will be killed if they are caught trying to
> execute on a 64-bit-only CPU in a mismatched system, advertise the set
> of 32-bit capable CPUs to userspace in sysfs.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
>  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+)

I still think the "kill processes that can not run on this CPU" is crazy
but that has nothing to do with this sysfs file patch, which looks good
to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
