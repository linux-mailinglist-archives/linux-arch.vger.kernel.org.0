Return-Path: <linux-arch+bounces-10409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D366AA46F75
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EC83A646D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0625FA32;
	Wed, 26 Feb 2025 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D9icv2Oe"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ABA25FA23;
	Wed, 26 Feb 2025 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612698; cv=none; b=j/1uHQakBj8wcUsoUg3N8RREXUPT8oo47UI5rcHHZduX84/DZYpf0HjfAp/jgnDS4+6ei0LM5BdyxOJxKW/JlsjqdrfEfbkz/zW4VCh9e/KjRJXhH2YKi7OKk5Ca5lTg/tkXzikvwxNKAfp3EYp8YjDmVZiX1SGM1Rer5v+4epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612698; c=relaxed/simple;
	bh=ta9421UjHvWIHjdsl6MGoh7QrZef/XCE0ZzA4+ffJjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8ilbSUC8R89KU7ELNfugY6bBhcFNKBHep41lbM1xyHkYHBM14a2I6P7VmkRh4N7VUPn/MAr4jZgCKYI3dGDDGJzPeHSMxfThow7PQurqbqEDwR8lVYy8OX6CAG+GP4zLSP0rfTfc3E7Y66fGSTH8qb528B0qcE2wTtc5pMwWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D9icv2Oe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C950210EACC;
	Wed, 26 Feb 2025 15:31:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C950210EACC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740612696;
	bh=smjit/QOli8nDcBTnlq+IXvVJxQjsbEgJ6Aw5iXyn/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9icv2OehF8C4IQm6v8VGElOql6Tl2Byga40BAnvuJFcSL21kP6EiJAZapo85yaEv
	 0z+DfrPz+nWW/C92EgQK94mRa2xtr+gXgtV7CR0P6fCXsYd3zisGZxIkHJ9S+LQo/Y
	 Fxf2YP+gaMG+c+MaB8mm2wGgwpFRD+e7/0qmWEYc=
Date: Wed, 26 Feb 2025 15:31:33 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org, vkuznets@redhat.com,
	prapal@linux.microsoft.com, muislam@microsoft.com,
	anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v5 05/10] acpi: numa: Export node_to_pxm()
Message-ID: <Z7-kVXsMrhhNV17S@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-6-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-6-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:07:59PM -0800, Nuno Das Neves wrote:
> node_to_pxm() is used by hv_numa_node_to_pxm_info().
> That helper will be used by Hyper-V root partition module code
> when CONFIG_MSHV_ROOT=m.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

