Return-Path: <linux-arch+bounces-14969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A9C714CB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 23:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0CDA4E207A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBA21D3D6;
	Wed, 19 Nov 2025 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6nhLkGs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC82F5B;
	Wed, 19 Nov 2025 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592066; cv=none; b=o8z+2hBTkdXGPkLqpWovOymHC3VSqZkJTKZ2x4zv/JPzPzXkrTI97e8UH5YzFa2BBjQHuVDcA1WEaCTgvNmIQWKEU+83Q55JCD+MAZxxK3s0x0nCJqmTJ6XfmkYP5OHtZwDXG5GMP3LZksMDnyCqNQCcUHCs+qyOUR8cRBCgvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592066; c=relaxed/simple;
	bh=621P0U/ZMt9tfYhYpJzFH9MENbuLn8U74VwfdbaCPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmd6ObRKc7Sf+VwSnCNoCP4z2u/BUq0+6CgcGmU1UqozZKAuobD84v9bu4r4vUq7KfmUG33aJmcvSobhhEftvJKKseeljuEJZEtYUI7HojDRmCaocn0+8GTZgQa5oqwBhVDevjtsomug+4G6Q7s7kwSSPvMSMCma37raY2UktTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6nhLkGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ABCC4CEF5;
	Wed, 19 Nov 2025 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763592065;
	bh=621P0U/ZMt9tfYhYpJzFH9MENbuLn8U74VwfdbaCPcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6nhLkGsqbguAOhXecSgsGeAmS5FWmPuncCmtlhyfugKFhj4ajks8EEEfm6I2n12s
	 85/HMv7UNfckOzrYLWFGN/4fh4McgSbveXPT+BX03o5hwYrHo0CYjzXgVlHoizRmGs
	 LGEksWxWWBPskpE2YaglnX9OvbYv+b/szfG0L2Rn6QZLkdBClnHgBLwmj0AV0h9kpF
	 GnF2Iz17WrlWEXzyOJ/+EYr0lHQ+YjV05Tv0b8MgPMAMGAruWq//Vua0vm5rzYpZ94
	 we/VjSi2R1VClnL6MFdBCDa5FeDqPAzHpO007LFlJm0v43VqS+K5TWrpVO4vV/gCVO
	 I0T2b/JvorY+Q==
Date: Wed, 19 Nov 2025 16:41:04 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
	pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net,
	david@redhat.com, mhocko@suse.com, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 25/26] dt-bindings: reserved-memory: Add Google Kinfo
 Pixel reserved memory
Message-ID: <20251119224104.GA3371358-robh@kernel.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-26-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-26-eugen.hristev@linaro.org>

On Wed, Nov 19, 2025 at 05:44:26PM +0200, Eugen Hristev wrote:
> Add documentation for Google Kinfo Pixel reserved memory area.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  .../reserved-memory/google,kinfo.yaml         | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
> new file mode 100644
> index 000000000000..12d0b2815c02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/google,kinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Pixel Kinfo reserved memory
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@linaro.org>
> +
> +description:
> +  This binding describes the Google Pixel Kinfo reserved memory, a region
> +  of reserved-memory used to store data for firmware/bootloader on the Pixel
> +  platform. The data stored is debugging information on the running kernel.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: google,kinfo
> +
> +  memory-region:
> +    maxItems: 1
> +    description: Reference to the reserved-memory for the data
> +
> +required:
> +  - compatible
> +  - memory-region
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    reserved-memory {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +
> +      kinfo_region: smem@fa00000 {

Just put the google,kinfo (or google,debug-kinfo??) compatible here and 
that's it.

> +          reg = <0xfa00000 0x1000>;
> +          no-map;

You don't need to access the memory?

> +      };
> +    };
> +
> +    debug-kinfo {
> +        compatible = "google,debug-kinfo";
> +
> +        memory-region = <&kinfo_region>;
> +    };

