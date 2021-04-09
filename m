Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38C35959E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhDIGhw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 02:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhDIGhv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 02:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9741F61184;
        Fri,  9 Apr 2021 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617950259;
        bh=EtQ/gzYGp5NP4QVNQHPkaitLS88uJCVu4FYhHw4EZlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V00TpJ0nXQoPQBfXFWwpv2X+LpH4kI/qYjJamhh4EpqGfXjN5dR1cNB3YsUFHX90S
         FCXgFL+ty3GL83FJ3Ltn4qPD7c+eUqIPTNDES0/acrnXRgfq7AhN42dqPMsUwhJzQo
         yw5wYsKZ8i9rdR6kDmcaNVs/SfW0LVQVwmzyCkKE=
Date:   Fri, 9 Apr 2021 08:37:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/20] kbuild: arm64: use common install script
Message-ID: <YG/2MKfa19d2sF6l@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-10-gregkh@linuxfoundation.org>
 <202104082007.88622E72F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104082007.88622E72F@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 08, 2021 at 08:08:18PM -0700, Kees Cook wrote:
> On Wed, Apr 07, 2021 at 07:34:08AM +0200, Greg Kroah-Hartman wrote:
> > The common scripts/install.sh script will now work for arm65, no changes
> 
> nit: arm64

Hah!

Thanks for the reviews, I'll be doing a new series soon based on
Masahiro's reviews.

thanks,

greg k-h
