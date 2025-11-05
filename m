Return-Path: <linux-arch+bounces-14524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE03C3719B
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA091882FBC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A616336ED1;
	Wed,  5 Nov 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caKRYsdt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0279D2FDC4F
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364046; cv=none; b=Qm5eIgFDOB1R5iHYAyjVu504gv4KA186m47qrfBq9ngHfuVtdqIghyuu7Sf9G0i/CFsBObaLCiD/0SWheanBT+Z9uKUH9shIYJew0zh1lA53/HT1JjyRl8P/jQSAv1RZhfegNeQKwsnhqOypPZuySMk+SHox0knOxR7y8cWL7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364046; c=relaxed/simple;
	bh=6xrOD9swTEvrak0LhMfPK5DhY7OUNnrkGwLHcRPL30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4m/VdTGxq0keNxCrKjtKpDNSoJrVrKHBJyTQMVlehI32aaEgQCWOGeBDkHmzWyPsHxw6z4rWtRTr9YuOozgJvB0MOuUrPNF1DzPteSiBeB5rGm9G6rs66IADgdJ/SFTC4ggQtHNREy8dSjHday+P+hzkZffrBIMNwpgHOpoA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caKRYsdt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a226a0798cso117329b3a.2
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762364044; x=1762968844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=caKRYsdtvKllX8CzsiFUc4zpvhzFGohX2iqu8C541hMlaAlV/GArvWcuIUYcNzqtFF
         iZsHa2KgnDOjipZbTsQBxz70O3SdbGvGjErHJFacdd81mG28AvBExOrrIYqB5rnQayHn
         Wlp+5I0CQOH51sTOzZtXst6d/KqjDDh1X2QbZ8V7+8o8slZTSt0YSBChAZC/EWTvN8Xc
         /1bOn/adVeZxgrjzguPfyLMpPT00DAZT15nxWOuBBxWcT1Wo5M5hagVt+GO3LNGUEdqt
         7a9vvGBNhOBjTjs742uZ0lKVPnpPTnpKMyYukgbYWlYody/AKXX+XGmmQPruLqbEEbZD
         mgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364044; x=1762968844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=ezVWhWRXqqGKI0K+L/tltYeVu51lQmYbtvqqZKsQbsBzR3dew7BikiNnV2mJJi7E9a
         muoGBgIN//P82y6XlOYEBDPMCrmQnrZZx2bgD2k5Fl7GLReGUyfWQAg0i2kga3Z/7+bG
         AymLIXHkIg9NR0YflNgKZjScuXAy3ty3ef1aocbL6/yWGAboP39W+2ADc3trPfqRUnmu
         My1RS2dWuowjekAXWU5RwdQY74nTfZ5tKtmLQRctojaiswf8eoL0Who4xk7/R2zqn6Al
         +iZEiZhvKoJR5Pl7XLMLsTlYhBb5dX549hRWCq7qRaZYaVMrGmefWpPKh1XKi1OO3RCB
         KtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVk847+73cMod6mraK7KPpVn7Q1wfG/W7LiJ+GmbQkHPcqSR775erYN/zfXD5Hk8aZDyTdGj53+O4O@vger.kernel.org
X-Gm-Message-State: AOJu0YwT77MfgoJ9h43FqYYHzdGZ7NWiCOxOXiEN+q2Bnt+xUOXyTO+L
	FjzjiaZoxasC0Cx/MfhLMFb8bd3IqwvvRnd0JaJqiV2s3NoqGQUqwVjN5AjQ
X-Gm-Gg: ASbGnctGXRxo6haHvSUDyXh22MJYoeBypfiKgbFw8Em9MzcN8UNzspS/YXR6JOR9XFt
	d3q/c7951zliEvISx/oVv1IcESonHwHWxCNImLLSMam6NnspZQmrcTC8j2hjVUIErM1IeDyaXGm
	3hl9QRhfx/tGrmEBXbuF35xQSHWcQ0798xm64yaCo1Ac/gWFq8ee78oParhiopZ3HEg4BWXqEPx
	M7k/6KZzwB3GAcg1cLidHDS1CHAKzBcsb9egcPtdtz95hHS1dWXZ0oTKB2O/txvhaXO0vvXTqEy
	IFVTYsQwjxJY+OWoiZewlNc+hVL/L0lUtjzOjB2skDYQ23t8edePM+87MOUxjipnbQkhjCkqopT
	DDcsJ2tJx8Ch6nZAbHqe1OBcSh7SAo0hfpbxkz6KNkPQXy7iQcny27XSVd6n3U9JM+QGy/FCqmf
	VocI52Y2zEybXh5hFpce2DiSSoPMWEcpiTIjoHWfA5kfQIs1sLZiVsGe64pHUoA9EZLwHdfJV9r
	zZAc5YBJfDTzz35kYfFpp6xYLIZnhI54CNHi3QBffCaEBlfNd3h/hYemV+KB6fsK1U=
X-Google-Smtp-Source: AGHT+IGfpYym/+ciEUpgLGEk2Uo4k9tfz1NW01FXx3zpjWrnBawbwhix8S/o00+hWVYZ5LW7eOMiOw==
X-Received: by 2002:a05:6a20:7d9e:b0:341:262f:651c with SMTP id adf61e73a8af0-34f84afbef9mr4621605637.25.1762364044019;
        Wed, 05 Nov 2025 09:34:04 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a8044dsm6027302a12.16.2025.11.05.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:34:03 -0800 (PST)
Date: Wed, 5 Nov 2025 09:34:03 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQuKi535hyWMLBX4@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>

On 11/04, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 

[..]

> +Autorelease Control
> +~~~~~~~~~~~~~~~~~~~

Have you considered an option to have this flag on the dmabuf binding
itself? This will let us keep everything in ynl and not add a new socket
option. I think also semantically, this is a property of the binding
and not the socket? (not sure what's gonna happen if we have
autorelease=on and autorelease=off sockets receiving to the same
dmabuf)

