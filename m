Return-Path: <linux-arch+bounces-1798-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC98F8412B8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7381C23F5C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113CF14290;
	Mon, 29 Jan 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0zzEmelr"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71711101CF;
	Mon, 29 Jan 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554253; cv=none; b=FcuCFgbeYtECrlkGNQI2eYGBJwMnLFJHyZhQMwNIF52ZRoSJlY3WRoSwNYHo1oeRrjWD9FTDe1FwsCKtjXUU+WjOK/ls5cYAVFDeWnvbfS2+1gkyrccqtv/aC0WljGsOY7PSZu3sxLd2dekt8yAThQU0TX+luF4jkP0jLBMqyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554253; c=relaxed/simple;
	bh=NG8Tyu90tiRom2cpwzM2tkHoEbmUxw/zsK650AzFPm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsdJI0AFhmYrFlHRIc0Oc63YWVWWGz6Syq/kqfMGzvOcRgqqvHHXId9NMJ6dTVyJqRn0mkNucF1LseQyI2FkrX9n3LjT2PH5G1+E0uruXe2Uh45RHyhAHnSCyrjCBa4e2wa9EXVSQk8SAAAtnYModRpsCcSK1jek6yDmQqbl7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0zzEmelr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sKRWq6ksgkPBg9JPG7PmIqtGGw2idUn43y59rAXbEJ4=; b=0zzEmelrVAaPdMLUmxBTBV3z5j
	sTg5i55dwqZDW96ifCc8EFQl2eruj6lIVS7O9z09rE7JGbiRo16c1HH7SeeLDLGpGs+C0ppnWReyQ
	0WBVpmPXBZBb7PDbG7aK/uDwDi0LjFz9VbUboNJnl0mRN8R0o+gTtJ7843Viku/5QfW/sse084/0q
	hkjVxYraiwna/My790drFuDb9zU3EEtA5Ip2W7pWbsbp9MBiWxCqbCWxyi/K41HslwbJKXQN6vILR
	GmWxAjU5oQ35+TDWcVICaghbBUE2YA4RWUbBMLLwJ6Kg84oCzfjg3svA3tOSNHSrieiFFNR8EGlcW
	pgCTZwaQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWiY-0000000E1GC-03m7;
	Mon, 29 Jan 2024 18:50:50 +0000
Date: Mon, 29 Jan 2024 10:50:49 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] modules: Add missing entry for __ex_table
Message-ID: <ZbfziYbsRtIleZzQ@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-5-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122221814.139916-5-deller@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Nov 22, 2023 at 11:18:14PM +0100, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The entry for __ex_table was missing, which may make __ex_table
> become 1- or 2-byte aligned in modules.
> Add the entry to ensure it gets 32-bit aligned.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: <stable@vger.kernel.org> # v6.0+

Cc'ing stable was overkill, I'll remove it.

  Luis

> ---
>  scripts/module.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index b00415a9ff27..488f61b156b2 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -26,6 +26,7 @@ SECTIONS {
>  	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
>  	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
> +	__ex_table		0 : ALIGN(4) { KEEP(*(__ex_table)) }
>  
>  	__patchable_function_entries : { *(__patchable_function_entries) }
>  
> -- 
> 2.41.0
> 
> 

