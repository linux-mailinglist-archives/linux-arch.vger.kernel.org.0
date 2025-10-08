Return-Path: <linux-arch+bounces-13955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14348BC52C2
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1BF54E8A4F
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A928466C;
	Wed,  8 Oct 2025 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="graURhaN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A92283FC9
	for <linux-arch@vger.kernel.org>; Wed,  8 Oct 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929765; cv=none; b=Nf/fV7gSIkDlHkx37o4hwKrkaRsxgy7lkWTPjmqMZRkpQaTfaAfyH+cMwh+rEOskuUtmX00ZcH5OLzTBv2bPpmD2m+8m7dyox6WmgDGf3GvOj5SFiKCl2bzQ8vy6Nka+EBYbdhLUWMs6DucS7JQgyK7ZA0cTJhyFNrIoeTZcKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929765; c=relaxed/simple;
	bh=eC0mq9CHz0uy1+c4DF7V23DakyvbvC8nry8GMoB26yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsXcAnncIJpDRtkL4ujTEv7y+fJxIbNKXlPeUaze0jGh2yWt6OrnbhlBzV8kcEf6fltuG2ut82XJUVNG7NBnAZgCARBakX36TcI4MuxE5QhL35oIsLbt3o768b2n7EgnkC709jh9FYJS64Kk55MDijZfUraomgv294hWuBrIk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=graURhaN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so71369065e9.2
        for <linux-arch@vger.kernel.org>; Wed, 08 Oct 2025 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929761; x=1760534561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4U2xsHoGJTH7iHhQZXfBw8CarpzUw6iPe1T3ECE3xUs=;
        b=graURhaNgwJllCwU5YtDzDBBaSmXK3PBdOWI7RRmfvi2gysAJ5ppbQIQwgE00sYE8c
         UXnsxRtZzi6U8L1XbwORYaRWwh7H1sBbmACIiD/7yDA+IquarGI22YxI4iWJnCwXDbmA
         RTV4y9d3FHXdXz4aM/OhW2voQkJhtYYdBvIUsNBAbhjd6eFARG5+wvoLYh6rrIwYo8Zt
         ptFxciSPzXJ3NvOBQDSUzLZbLTv14QEnIneM+nLuT+cM42gf5zk3TG7mXJO87WaizOJ3
         pDeuIa+c55B1OZSeh/Un4DbgQfH9aixL4txAnRAA10LgrhBJ60jqDnWP9hofrb+EsA8P
         dJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929761; x=1760534561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4U2xsHoGJTH7iHhQZXfBw8CarpzUw6iPe1T3ECE3xUs=;
        b=u9ViAJBwXxVcDqkr8mBINUHQloB+wHSBAExXGfBnzxvzRhg9n92hTXxKkbns3EB6c7
         mT8PIrPC8jKWjhHFJvOJjmjYSh8tDfMKe6thm1zc8YdGydJSVVYHTayvGeWFEYA5eJbU
         lD3qms7lP4R53yKEBgPbxGGBjco1RYMSi5xVWwOAwfBFDqmtbfxi9fa/IPw191lkY/5L
         jpdW6JKRTC1JDOxNnAserSU1C6vbODywvapEANmU++OFMWCp56ED63gCFxUCBsJLaC7u
         OAIxSDU1nBUcb9Vs2+R6C90uKJIzethWbKueCH4q0ZPvm7WCOa/Z5Qg5mj0f9tbt68KB
         Jz6A==
X-Forwarded-Encrypted: i=1; AJvYcCWYQw+ZgPHQUUueNOPlgUyCXV//BK+JJsIfIlvk0K7CJTxoAFBwDuS63j9tRkYsc1SkLiii4N8mXjr4@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyLbDxPxY6qLRsWT53jnyx8nydrhwaJDCo5bAfmtLNWdo4a8H
	O+F7ZPunCMqqfjhbmH8iEwyDCWV/cQirpnODssNEM8HYMZ3mQik1hy9snbn0RTs8JNk=
X-Gm-Gg: ASbGncvgAnrS5mN6hQT0Jt0RjicAj+JZj9sPsQTFewJ6qn4gE1UJ5mE1uTAnwYWs0sv
	ZhlJ4ov7VWj+mvfKsuH8wffoQ2lw4gaKidNsY22Bv7qCB9Cn6Dsnxg+96gqXnPszUby+nGcSPnY
	eCX+aHjXIDc4bDAtV6SrDGuYWn1JdaEbR+fVZkWCe75FRMbnIvIZjbvF3NK5at/0dga/aB1opP3
	AStJuuDoASoLkhvnMmeC4XZwjbsdQilnJzurNrAXYrnaUSsmEN83swXCOtEApL7LPv1Wwovz2Eg
	AdWoDIgPwGEnbQjk2xMcVG7orEMNbGDi0yJ74psr6utxxcNH3Sg0fdRCJhE4GWhcEqSL55NPc3U
	WbKV/ahgN6Y8W3OoMxnHPIBV+8DCEOw7pGL3jhfeBHTXc5ZZfsbKHzGZeHV1HnShV
X-Google-Smtp-Source: AGHT+IEYSq0TP4pQ8Uu0J6YEh6RVoGDJ8QoABxOaZSJ8G000FXcsdbuhJ1AnUVCmEjMI85B5DM4SOQ==
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46fa9af8f39mr24232495e9.23.1759929761358;
        Wed, 08 Oct 2025 06:22:41 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c1726asm37099255e9.12.2025.10.08.06.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:22:41 -0700 (PDT)
Message-ID: <026b31a0-42d5-4f9a-8604-70f85cf203f2@suse.com>
Date: Wed, 8 Oct 2025 15:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] module loader: remove references of *_gpl sections
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-7-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-7-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> The *_gpl section are not being used populated by modpost anymore. Hence
> the module loader doesn't need to find and process these sections in
> modules.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> @@ -2601,10 +2590,6 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  	mod->syms = section_objs(info, "__ksymtab",
>  				 sizeof(*mod->syms), &mod->num_syms);
>  	mod->crcs = section_addr(info, "__kcrctab");
> -	mod->gpl_syms = section_objs(info, "__ksymtab_gpl",
> -				     sizeof(*mod->gpl_syms),
> -				     &mod->num_gpl_syms);
> -	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
>  	mod->flagstab = section_addr(info, "__kflagstab");
>  

I suggest adding a check that the loaded module doesn't contain
a __ksymtab_gpl or __kcrctab_gpl section, similarly how the function
later checks if the old __obsparm section isn't present. Something like:

	if (section_addr(info, "__ksymtab_gpl"))
		pr_warn("%s: ignoring obsolete section __ksymtab_gpl\n", mod->name);
	if (section_addr(info, "__kcrctab_gpl"))
		pr_warn("%s: ignoring obsolete section __kcrctab_gpl\n", mod->name);

-- 
Thanks,
Petr

