Return-Path: <linux-arch+bounces-4161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FD8BA707
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96815B219CD
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC26139D12;
	Fri,  3 May 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcaAekJg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B18282E5;
	Fri,  3 May 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717719; cv=none; b=PNn4x9RuruXKX+5k6NU2OVHF+Q8ArpGr9AfuT01Se5fYvS19Tq0R7bJ7W6+L/MA51UO8mjGEYccsuaUopMWqkJ8ZsDVoq/UZpU8P9sZijB1/Bxs9vymAxrwSr/JKkUIpdRFa4Kn6nYrzQU+y52n4G3NI9LBJ6LllJE+xAaoBsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717719; c=relaxed/simple;
	bh=iwh0xdjQBV1rMvWbejzBiO4Cm2ywVaCYNNzkgwWts0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAMVmS2i5YpKJj9UQNUFpQIeJFgEU2tWSIkbdzO9USO/Rsidq3me3LmryOGh8+UOoGDMoFGOCRsptUXt2uSpEuq6NXoq5wJEHtP6ejAqynbV8iMv9UXdjBoAK6pmEDRHAFXWP39NnI6KBI7/TG7a31Mxh83pRMswPXX5YHST4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcaAekJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81384C116B1;
	Fri,  3 May 2024 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714717719;
	bh=iwh0xdjQBV1rMvWbejzBiO4Cm2ywVaCYNNzkgwWts0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcaAekJgFy/ub8u/nLZ43cpp8Z3hWZWdQJNtfEPSpLSHsnvRSQ9P2dsYcsi2Sx3U8
	 CejoBqkoLSP0CHcFIXFqRGIfGEh9EsoSht2sb4QO3J1miDQbbWotJ+RuP0Zh+yExe7
	 oFcis4z/7AVU8HlLSG5M0ZW6I2pSvaISQO5obSak=
Date: Fri, 3 May 2024 08:28:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	amd-gfx@lists.freedesktop.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 9c6ecb3cb6e20c4fd7997047213ba0efcf9ada1a
Message-ID: <2024050314-knelt-sandpaper-3884@gregkh>
References: <202405030439.AH8NR0Mg-lkp@intel.com>
 <2024050342-slashing-froth-bcf9@gregkh>
 <d7f7cfae-78d5-41aa-aaf9-0d558cdfcbea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f7cfae-78d5-41aa-aaf9-0d558cdfcbea@quicinc.com>

On Fri, May 03, 2024 at 11:30:50AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 5/3/2024 10:42 AM, Greg KH wrote:
> > Ok, I'm getting tired of seeing these for the USB portion of the tree,
> > so I went to look for:
> > 
> > On Fri, May 03, 2024 at 04:44:42AM +0800, kernel test robot wrote:
> > > |-- arc-randconfig-002-20240503
> > > |   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
> > 
> > This warning (same for all arches), but can't seem to find it anywhere.
> > 
> > Any hints as to where it would be?
> > 
> 
> Hi Greg,
> 
>  I think the hw_mode was not removed in hs_phy_setup and left unused.
> 
>  Thinh reported the same when there was a merge conflict into linux next
> (that the hw_mode variable was removed in ss_phy_setup and should be removed
> in hs_phy_setup as well):
> 
> https://lore.kernel.org/all/20240426213923.tyeddub4xszypeju@synopsys.com/
> 
>  Perhaps that was missed ?

Must have been.  I need it in a format that it can be applied in (a
2-way diff can't apply...)

thanks,

greg k-h

