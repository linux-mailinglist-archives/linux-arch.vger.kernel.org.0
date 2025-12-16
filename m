Return-Path: <linux-arch+bounces-15468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5BCCC3DE8
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 16:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BE65302258E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5387355808;
	Tue, 16 Dec 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ak6pimUM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FF3557E7
	for <linux-arch@vger.kernel.org>; Tue, 16 Dec 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897980; cv=none; b=SS1BMmUDMNFlJwFvk6Sncxblu6I431ImvKo9SL5X9wQXH2rjVTlPbKiW7gnjr3I6HSn+4Kdwtj6gU9V7FU6D91ZmHmPMWErD6pfyVPxsO1SQbyG7rhQ8HKZZus35lkG70X1cgVI+E04OVELE4XRSE7EJ2SKLGy09JzPZlN5D3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897980; c=relaxed/simple;
	bh=otRnitXgK3YK8QOOnOlDhlnw9uTpljPxLSfkYiE4/jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T65+xA8e3hkK279EnMDlGs4pExl6eRt/AqkUTiySIHkhAICWPfCQP1HAICIXVmxH4e21tbWdJC1/kC0ElqrwteTDchsLarpMx/wLwh4cTJxeqdWbzuRBiY8jCr/SbePjEHF0zqaYSrxImzih6HoNJqG1Uc4NF0EYrjpu0McAgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ak6pimUM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso30584515e9.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Dec 2025 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765897976; x=1766502776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RaB9SM+pvwUf1QmqN2DN92hZRXQJ2LlXiPVs66C+PM=;
        b=ak6pimUMaCZZ/eH5zmilk5fKWiWmW54oMRx2jPSJVi1CVmJPC98gQhTksBJFW+6nHP
         DLE/wPy/UVd/TBJCpnXSaDfkC28opZO1OGWlzr6THu7BZffJesytfKxKrfaEWWQOvJdB
         Ro9a3MGnc9Th9Aofq0LHrc4iXCjQxD7lXbdtME75auAIp06AwNFJk17U4gcy4sEeP6BZ
         iRvSkXX1cwVC/goq2Jw4EZ9m/Ie8IaH/U2IsFtT/U51CKl+hcFy8uf0/8tp07WkrieUV
         1JAlv/ia8ggNysCdeLTYF/v1MLare0gRW8hYTq3ZcLxz/6Or+4EXMTge1Q2fGGhNLp8K
         cYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897976; x=1766502776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RaB9SM+pvwUf1QmqN2DN92hZRXQJ2LlXiPVs66C+PM=;
        b=X82BJ0deGxPFdGHsElRLVSSryVMZ0C4HUyekCRTCHpZXZ3wp8/wC0bo8IuoedVe3KF
         5Q+uQdxq8ouZh4SErrgOeu7Utf6mQwfzUNE9Ejey1qIVrV1sjVaJjsehwfJW9y0tNfVt
         nTg9Kqyn6x2pjDB7sr4i4RHL5WhUx0ETrr4EPhEUcbsphpcURztzdWX8fdKogepLUEmY
         qcLxoMk996uNXrKPjpjlW7DunFAGWI/VJ9fRmmYobUeL+EzRI1fULA+p7CavH7pXlq5W
         jzdiprlUY4FqKRc0F4UWRsN8JtRZLP3+rHZQo0dLVWNqG4ugG1+tElGzmWNP1l7dvsR6
         tuJw==
X-Forwarded-Encrypted: i=1; AJvYcCUVUJHcK6POJMjDI321m8qLHnv4E4pmkJIL3p4Z5Z+8vnVP+zoyJbDK2/Gow7efI8Kj1i57eshkgb8j@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMlthIgCAHiFQOdSr8v6c119WLVK7aYZCyPNw+V9NcOu6BSir
	tSuzlotXbS1SDkUmXRC5we439OL2vuC6E4xOd816SCrvldJGrV8fTIJ1RbMIWBr5GUA=
X-Gm-Gg: AY/fxX7sFOxrZhWZ5uyL1VpcP9golfXE+wNRwP6CatlwH9zyw7PsUqiRwrETd8oBAkT
	+XEGHYXjufWfZ49GAJ96YYwo7nFhYcQ0dyhoj4i8td71VIH5bnbZRRv90TgXtV1L80sL+cbKwqt
	7B29A+3WWc1l4vmjinravKJTolpO1MnZtyvRpX4FepQFXyWt5nSxj2u7N+aPyIdx+qMqa3TmMqJ
	NhjY+uM9G1haXY478RLlLo9UHAOPQDrEHP5j6EF/r/jJVd4z4LYRcUCR8gMTFShHy+MaGmz7hhD
	wJGuiDsEZrTgyd0X1xNoTN994aSLjhft0mf1FKZs+jIPCAlI/E+3Kb5ZBI9kmx6SZY3X5VGoU50
	TiVXDr4vbu4pKCHqt24aH6OeBaNsaDbxwBoIGIYsMy/TdKn6FUlKLwZ22Pqw0UvOuat3PuDDLHP
	t4SbNAMsgQ1T+lsQ==
X-Google-Smtp-Source: AGHT+IFg1h+oSthyGc4tPORkNrPPpnVeUr6FNMPfEJgnXBupogksrkrfKGsIU7DtuK9+emJLDR1CpQ==
X-Received: by 2002:a05:600c:608d:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-47a8f8c18d1mr142495795e9.11.1765897975942;
        Tue, 16 Dec 2025 07:12:55 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd90b81e6sm12034075e9.3.2025.12.16.07.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:12:55 -0800 (PST)
Date: Tue, 16 Dec 2025 16:12:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
	rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
	mhocko@suse.com, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 21/26] printk: Register information into meminspect
Message-ID: <aUF29MLUj3YRh4v_@pathway.suse.cz>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-22-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-22-eugen.hristev@linaro.org>

On Wed 2025-11-19 17:44:22, Eugen Hristev wrote:
> Annotate vital static information into meminspect:
>  - prb_descs
>  - prb_infos
>  - prb
>  - prb_data
>  - printk_rb_static
>  - printk_rb_dynamic
> 
> Information on these variables is stored into inspection table.
> 
> Register dynamic information into meminspect:
>  - new_descs
>  - new_infos
>  - new_log_buf
> This information is being allocated as a memblock, so call
> memblock_mark_inspect to mark the block accordingly.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>

I haven't tested this. But it looks reasonable from my POV.
I assume that the output from the "log" command was from your
synthetic test so that "crash" was even able to print the messages.

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I haven't attended Plumbers conference this year so
    I do not know what is the current state of this project.
    

