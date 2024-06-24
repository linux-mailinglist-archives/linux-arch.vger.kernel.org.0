Return-Path: <linux-arch+bounces-5052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7117915607
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 19:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CF2B23605
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4F1A01AD;
	Mon, 24 Jun 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C35ont+Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9619FA8C;
	Mon, 24 Jun 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251756; cv=none; b=JrAMXLXKCPYbzOf2Tp7mTRqur49D2XGb35v8iMQg1NzdlRUsgEiB/oqwp/jeTVppB4fRSATXBw7hIYC657ZqBCCe16RUPZB/rPwdh6rOduEhuvCr8wxD9ackyTss+4CqGS8+y/ZepDqwcy+HHyXUuaVU10u5/X+YEClRdqGfMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251756; c=relaxed/simple;
	bh=RWADVfhWFlhGHNw50SjTloO0CnEZU0GqVDdf9sCPQNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfy6bG+tw2DADkq5xgtly0QxKCEIgxfZo3MoIk9pGwgBF3plVElFR5Mvu6RkdxN7ZaSBk4hm2mO76rqPigFYDiCl3Qd/jQjma4wtH82jR5oUnxvP/wGQPYTH2CDssf39HSs/6VbbF8zkRWfGQPBmJ2gjpDz6bIssMGpvNOwaYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C35ont+Z; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80b58104615so1111422241.1;
        Mon, 24 Jun 2024 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719251754; x=1719856554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpLcz/0IN/d1gmOSMD86qgPO3fLQN3Whaw5qjKXYF8E=;
        b=C35ont+ZVOnFNZ7qV4e8MwqLAXmadSllJ8yA2gnmtFa3NGUvFYwQ4rP4ij7sKy+aio
         UXjdinMR5jBvCKfC6XWBaJFafzNI20Ns5GVPk8XFsFaaq0HhyhGW3DC6JmkOCECAwKt/
         abTX1oQ36SychUTqgL3Ozjjl9w+H011kTNRhmTircdYdXuwHaV8eNYrdR6SY4eySJUu4
         q+oTzlOIG2+Z18K2C4AODygWkzHu55IwyjnYB8vCWfTEZSRibce9VCFPXYXqwDpip4wz
         ecBV0LNa68KXljOzKbbTSbZ5HQoR162SHjJtNMuTfX23GxLkEqu1dyRIeELPa1475U+X
         pYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251754; x=1719856554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpLcz/0IN/d1gmOSMD86qgPO3fLQN3Whaw5qjKXYF8E=;
        b=lSmDbEHmcFDyg5Yk7mqdxmYuMkbJFAXp15mEZon4I0NdwRvEJaXswmPSKKzYx1qqqM
         y+ssnHVj5+g0olUbSNpPvRuMqC8muoPSE686MYvvkhtMV6AZCbVFvs/dFAk8ZM1DZilp
         tq5pnIoUhz+s9kAByFaMp+ZUyXQd+3P11sYSIy9pvCYxWrW6J0Z26Z1p8lrjR1K30wXN
         VZuNoQfRptJfhQQzg246JGjp3WvAo5l3XQ6RuyHSt2Y+77SM2ei86yt5xey4NFiy9lf0
         /2jbEEbR7rQ1xyNWdruupWybTONWiEbmnGX/aNfAK+Y63V+l3/RSxJwDILrzYf7sFfpK
         p9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtAJ3N+kWXz2ggUHLX/BQ5/LrEVMAWKWzjDIQHOtHfZvusuk5pfszf6rrmU782c4LJJiGREkEUl/jL6XjlPnEa3e5kddhmb6L9ayBa9DwZRRgM40WKUXOrtDk5D63uvWNJkTosXs8lHxtcJJDUjq7dqfyIMmjknKzcwHNp/XQkQJD7ZfTJSPZkEm3iqn3RlRHeIMDzx01HpfSVBQ1DJEwWuNSAVnLyFw49P6IaGv3BrY537GNTXk89UNvq3vo=
X-Gm-Message-State: AOJu0YzjrabFpD8C7hUO5phtbilItylNIO4e1KpMijNNOhdg7wZzBugd
	zJyEN4NdLtN8S8UxFf0XPqKgjNAH2P4qqITGzdtwk8ToSpDykViz
X-Google-Smtp-Source: AGHT+IGktNPNlajbgEwLGV8CCMDaPBCtad3PYAuUdbhVE87qwtNwyWAb1yU6hGLFoKjYjjutynzHWw==
X-Received: by 2002:a05:6102:418b:b0:48f:4507:84d1 with SMTP id ada2fe7eead31-48f52a44350mr5880279137.9.1719251753927;
        Mon, 24 Jun 2024 10:55:53 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef312a7sm35918576d6.87.2024.06.24.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:55:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 768861200043;
	Mon, 24 Jun 2024 13:55:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Jun 2024 13:55:52 -0400
X-ME-Sender: <xms:KLN5ZsP3KRGNsSDceaZDk3UFA4jOft_u2wg48tjEx_0DtTcUScs05w>
    <xme:KLN5Zi_MMc35phgytbkWMEk5Zxhtt2pjhltFMpBrS2bsEVtYRdSZcdM5elv6WLQMw
    LUImd6tBKyyi0HFgA>
X-ME-Received: <xmr:KLN5ZjSCWhCZf3yOFgyCusgS1OlftBCa3Jg3hAASyW1NXWisiBF-QNLfTrFBEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehue
    evledvhfelleeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvg
    hrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhf
    vghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:KLN5ZkuUV6zPFB2cLz-kR2Z8aTMedu9T3FISXobjX-Map2WHhDWgzg>
    <xmx:KLN5ZkdK7QufnuuKdQuQ2UvTx-AaQGBAjN0vIl2ugET8IEo9alGunw>
    <xmx:KLN5Zo0GH9HvYaP6Md0iuwu_jtHHS6Fr2_Y-mM1yvTKbqou1MwZMFw>
    <xmx:KLN5Zo8JsqzF27tKSzW3moUJzqEXB7DDMc8SoT4UgI3LjPOWRIUMDw>
    <xmx:KLN5Zr9Y6VY64Z_9SLci431ZmBaOspT6gBem6CRLppE_w5U5vVn3UozH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 13:55:51 -0400 (EDT)
Date: Mon, 24 Jun 2024 10:55:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, arnd@arndb.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org, maz@kernel.org, den@valinux.co.jp,
	jgowans@amazon.com, dawei.li@shingroup.cn
Subject: Re: [RFC 11/12] Drivers: hv: vmbus: Wait for MODIFYCHANNEL to finish
 when offlining CPUs
Message-ID: <ZnmzBi2y1eq269QA@boqun-archlinux>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-12-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604050940.859909-12-mhklinux@outlook.com>

Hi Michael,

On Mon, Jun 03, 2024 at 10:09:39PM -0700, mhkelley58@gmail.com wrote:
[...]
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index bf35bb40c55e..571b2955b38e 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -264,6 +264,14 @@ struct vmbus_connection {
>  	struct irq_domain *vmbus_irq_domain;
>  	struct irq_chip	vmbus_irq_chip;
>  
> +	/*
> +	 * VM-wide counts of MODIFYCHANNEL messages sent and completed.
> +	 * Used when taking a CPU offline to make sure the relevant
> +	 * MODIFYCHANNEL messages have been completed.
> +	 */
> +	u64 modchan_sent;
> +	u64 modchan_completed;
> +

Looks to me, we can just use atomic64_t here: modifying channels is far
from hotpath, so the cost of atomic increment is not a big issue, and we
avoid possible data races now and in the future.

Thoughts?

Regards,
Boqun

>  	/*
>  	 * An offer message is handled first on the work_queue, and then
>  	 * is further handled on handle_primary_chan_wq or
> -- 
> 2.25.1
> 

