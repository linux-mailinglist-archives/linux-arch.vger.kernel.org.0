Return-Path: <linux-arch+bounces-14952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A3C7038E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 048BE3C1479
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F680341059;
	Wed, 19 Nov 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVDFHrJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA708327BFD;
	Wed, 19 Nov 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570001; cv=none; b=oa1TZGm28Q7/JGZWQSLxMeBZZ4x2UPk16XEYf5kt2mwsVAPRlbHLPrUp2RRLPWOUD08jARaiGbBGFnah5TMhQtjPYIqpHlLWRUbktviey4toK6Ft+HHOavhau3LQtEDRCHzNuENrm2UvNcYa3SS0AIRcKSRk+fe+Vd/C394b49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570001; c=relaxed/simple;
	bh=i7tu3yLM0VynVlcY5bqcs6DeJo41e1PUYhoSNib7lwk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ij42rkd2UVI0bGlBBkx7gG1+Y3cj3CvEyqmjGpwJDYLQy6UGqoqbxo1WUWFvqpLqMz+3uD2w/wYeTTOw11xayhQ5fW20Lag71tivOgK5wLoLZrZNeb5b4R5jc7Zxehw+vovVuO1A1Vcs7t2lw2sIpPqoay01i8XR1w8e+iHn3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVDFHrJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFF2C4CEF5;
	Wed, 19 Nov 2025 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763570001;
	bh=i7tu3yLM0VynVlcY5bqcs6DeJo41e1PUYhoSNib7lwk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DVDFHrJk84A4zymiV57X3ExnwuLvW0CE/LGPojju+eu4wWuy7NJcmGzR0WD7DMXPC
	 AR7po6HBkGfMn+DMQZAO/WfAqULzdm848KNna+EoU8nTyUHFyvcKIzqdQ4v+KaQkYN
	 8MmjEa1NIFK0dl+BkmW0tETpK18AwFc28h6WQCq9E0W/TN8S3eKWprf7yCc749NBi3
	 cjKnqViCC70PjVKaMtt1MqZwAOk0USTkCrD8nNBf4qpIKnbJqc+R8gpd9sbtvoZh7g
	 BEC18R6G+GcBu2mVDYrReRdyKMAuKyeiDrTf1nnUuAxDd0ju9L+s+dkjzexN8nR1zb
	 wxU1oQwlYLUkA==
Date: Wed, 19 Nov 2025 10:33:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-doc@vger.kernel.org, rdunlap@infradead.org, 
 tudor.ambarus@linaro.org, linux-kernel@vger.kernel.org, pmladek@suse.com, 
 linux-arm-kernel@lists.infradead.org, mukesh.ojha@oss.qualcomm.com, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 mhocko@suse.com, rostedt@goodmis.org, tony.luck@intel.com, david@redhat.com, 
 linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-mm@kvack.org, kees@kernel.org, corbet@lwn.net, andersson@kernel.org, 
 linux-arch@vger.kernel.org, jonechou@google.com, tglx@linutronix.de
To: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251119154427.1033475-26-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-26-eugen.hristev@linaro.org>
Message-Id: <176356999980.2657652.14038918040469312144.robh@kernel.org>
Subject: Re: [PATCH 25/26] dt-bindings: reserved-memory: Add Google Kinfo
 Pixel reserved memory


On Wed, 19 Nov 2025 17:44:26 +0200, Eugen Hristev wrote:
> Add documentation for Google Kinfo Pixel reserved memory area.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  .../reserved-memory/google,kinfo.yaml         | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reserved-memory/google,kinfo.example.dtb: /example-0/debug-kinfo: failed to match any schema with compatible: ['google,debug-kinfo']

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/google,kinfo.yaml
MAINTAINERS: Documentation/devicetree/bindings/misc/google,kinfo.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251119154427.1033475-26-eugen.hristev@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


