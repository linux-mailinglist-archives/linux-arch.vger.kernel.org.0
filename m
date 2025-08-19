Return-Path: <linux-arch+bounces-13198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC6B2CA7D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BA7686F30
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF613009CE;
	Tue, 19 Aug 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8+Ikq5R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0682C3276;
	Tue, 19 Aug 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624144; cv=none; b=l7HPFsg0SvkcLDSze0WF4SvcnwXmY2282V+Fmm0blwTv6O0IYXNMA8t1FzKMEGjpgnq7QtGrTP6E5EbGlQutirFAQLWyk9QVdencoFhmjEDaM3VctL2BLq4lf0LVz/ouxuP5XOIP2SAsP3eOlqPCLoqr3QFXr+JIP7sIpb5Om8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624144; c=relaxed/simple;
	bh=bezRgajI/HkniPJe615IxyTe1EqBbqXSxUNUgUJnxkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+XQkPV4jJNFUggvTmD2Sh0Lo2tzCQiknG6kQg106f+YZCJSOj5XslsQAnM2UgkGun0I+Wn4bPtwKgQKlw5fi/by34BXDwI++vdj+8NmDdeSSzE5F/nFl1AD2mB+L4q/Yn/ZoBQCdQQh09EwvljEgnWWSrO34IiOfaAzsPreZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8+Ikq5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21614C4CEF1;
	Tue, 19 Aug 2025 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755624144;
	bh=bezRgajI/HkniPJe615IxyTe1EqBbqXSxUNUgUJnxkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8+Ikq5R+FntBHfRvfMfDjFFaX6lT05h7aq2YCiTByan8EiV1OGv7wI4Kl2DbvYCY
	 uxL3jPblvEvJ2g7SAysPUzWr1mGrPWu+/tfRJmmpBvzWmChoY/Mn5vEyGRK+BFFIoi
	 K72wJi03hkFbfNWQG0S99zZwEdbi2DTidVfq2/cST4+pWqD6yHCODm8FzXBZMQGYPI
	 8Q7NfSkXw57QFui9funZAtXEbeBwzT5Nf7edH4KnipTsBHycqsan6tG4kxWH6//9Ky
	 rK+0cFANdiO77+IHA31rgFiCe10DzuqCYx3JRxmf7nSMjhK8VScRd8WzyRfrt/G9CC
	 bB7NvW3EG7o6Q==
Date: Tue, 19 Aug 2025 17:22:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
	decui@microsoft.com, arnd@arndb.de
Subject: Re: [PATCH] mshv: Add support for a new parent partition
 configuration
Message-ID: <aKSyzopAGQhM61B0@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
 <0a0c8921-9236-45fb-b047-742a34379e63@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0c8921-9236-45fb-b047-742a34379e63@linux.microsoft.com>

On Tue, Aug 19, 2025 at 09:17:27AM -0700, Easwar Hariharan wrote:
> On 8/19/2025 12:29 AM, Nuno Das Neves wrote:
> > Detect booting as an "L1VH" partition. This is a new scenario very
> > similar to root partition where the mshv_root driver can be used to
> > create and manage guest partitions.
> > 
> > It mostly works the same as root partition, but there are some
> > differences in how various features are handled. hv_l1vh_partition()
> > is introduced to handle these cases. Add hv_parent_partition()
> > which returns true for either case, replacing some hv_root_partition()
> > checks.
> > 
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> Seems the plurality of subject prefixes for drivers/hv files has been "Drivers: hv"
> so far, including the 2 commits for drivers/hv/mshv*. Are you planning to change
> the standard for mshv driver going forward?

IMO it is okay to have a different prefix to call out the commits that
are relevant to the mshv driver. This eases the burden for anyone
porting the changes to a different kernel tree. We may also touch many
different parts of the codebase (though not in this particular patch).

Wei

