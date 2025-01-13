Return-Path: <linux-arch+bounces-9720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD852A0BB95
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 16:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7213F3ACAE7
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11122CA06;
	Mon, 13 Jan 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ezS9Zan6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474C22BAC7
	for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780958; cv=none; b=BJ1S9VqK/3kjZq+6PN//3lxN5xVum/7NEc/XBDVd8BJPIFE8U5s2KA7mCMgeSQ/lXctQ+DFlhjkTaaGujqNP46oTP9rX7Q/BG1m+dJUg2DCijJ4HHPNpwcn8gYktRHZ97A+x8N/S4uoqeRzIqbt16VH728knJHzCti9pAo31Hd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780958; c=relaxed/simple;
	bh=kRhkE5n7v4Whpf8fVWtjsSx5QcAs1w8kpM+1riSUPMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv63BPGTSI+Z64IhBlbXPg9TiFNPcHekO7ByApRDJCLCTjvPbVzj8BVsG/50yHDbOPeUz6z6o9DZuMIM8nO3ThMw1++Rgc17bHHFTAcJaNSqTkXeIWmfIIEvO7QcwPmqccDYZ5WvIBiuLVRxJPuLmJRPPCD7g3iHgskceTuIYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ezS9Zan6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361815b96cso31098385e9.1
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2025 07:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736780954; x=1737385754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ObLtarfixbuoeU4sYBvXiHlMBkt4zlHaerO6eMC7G8=;
        b=ezS9Zan6aFB4fwtUVr+qGWMrowQXWc4kz8fChye5r0blUpdRTv6qref1NlbsYkcqjB
         POEGkDcCgzKItEhlEjb9u07bLwuX41mcm14ZJFod4dyR/7BRNZtcQ66g0GN4692ssqoE
         MMDLRhtqiTDWeTaMQw0X8vhWa2sp342h83sW0JL9lzb2l0dpZBhL45j/iIndd56GsaxG
         WzyvE5yRM7r9aO+9lqlrNOBHEgBrsG/476rGPiczl10PeTfT5dlJX+T5kYqXfFW6LGEW
         YdnwCjsZtneV3xbZMgPZ76b4Koj9cgxwibhszAZrTfMorrKByyzS/a9HrVZEEs9aHlvi
         qWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780954; x=1737385754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ObLtarfixbuoeU4sYBvXiHlMBkt4zlHaerO6eMC7G8=;
        b=VLpQXizntSdFY6YKuAP5BpYZrTyBge7osq+wtiwZb7pKIvEQJ0o7PjIIOVG3xrxX+X
         YqR4N2ULgTksOssWtV7kw1VKNDKKcq9sAoP5iw4c4bDwL7dx7e0hwgB0dKU978PDiBlF
         qcIfWaJwrk7pLyRogOSGfXcFoqZh53IODPTMdRp3SlvJ5uE/weK7Zd9kjDqIpOzKTiQu
         D1EuKL8PerAOL12Aqbx6CtGgVDyXZZIB+RBYQB21cz1onBI3EhgBR7ln493H/Nx4QscR
         GJGYPJPVXvxrS7QUJc4p4a9J1a6zHOREIoieR/hLgyy7iC4RCyTPCZxpVvqozwQEbdqf
         VmMA==
X-Forwarded-Encrypted: i=1; AJvYcCUU2o4CaunImAiUVFlb0HCdmBUjvlc1dwD86MaT2cTwGmK+1yEFmiHVLbj0v6vgqu+IZZ3scO0r3MGB@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYFModdxvTBrRoFNhcmAxuBCU8/rAn1gAZMQopBW8jHOG14b1
	7v4MH0ZKCH4lzxS8aJnOR5JHDNN48AhG9K1VSqFuoLZY+QJQ9qcklprpKTfnDvI=
X-Gm-Gg: ASbGncsN3zHihPliud7XoxhnTVq7dO6z2eny498So92mGn3BK+Fyb+bBcOeahNU1aIu
	2XAoEkU4L/ht9p6oQrts1yMjX7H5g4ohR9xXQL79A9ujtX2KGHglImHUWQa7rWgMbarTc3wTvmZ
	vYrOyhWZEfddChxJBX80mCr/rizcxG7TV4kNd4oA7tbJ6/IDuqTR8sh6PExz5kFUrDOflJyxO9m
	b9Jmx44426mUoLOLzqeiv0Zi39Pd/5m5wVUxZtfsPM92T/L96VIJzMAx2UB
X-Google-Smtp-Source: AGHT+IEsbWMFnleSfxZtUy8qfCZDcHp6iHBDwND8NHE6D8XDA1Ya1X/7dUhnhfiTLdJ7vz3kEw7s+w==
X-Received: by 2002:a05:600c:1c14:b0:436:1ac2:1ad2 with SMTP id 5b1f17b1804b1-436e26c0400mr171652465e9.19.1736780954585;
        Mon, 13 Jan 2025 07:09:14 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0f69sm179356045e9.13.2025.01.13.07.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:09:14 -0800 (PST)
Message-ID: <ebbd79c2-50fb-4d9e-aabf-a55ea463c494@suse.com>
Date: Mon, 13 Jan 2025 16:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
To: Luis Chamberlain <mcgrof@kernel.org>, linux@weissschuh.net
Cc: Arnout Engelen <arnout@bzzt.net>, arnd@arndb.de, da.gomez@samsung.com,
 linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 samitolvanen@google.com
References: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
 <20250109105227.1012778-1-arnout@bzzt.net>
 <Z4FyGEXBK4EUi_Oq@bombadil.infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z4FyGEXBK4EUi_Oq@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 20:16, Luis Chamberlain wrote:
> On Thu, Jan 09, 2025 at 11:52:27AM +0100, Arnout Engelen wrote:
>> On Fri, 3 Jan 2025 17:37:52 -0800, Luis Chamberlain wrote:
>>> What distro which is using module signatures would switch
>>> to this as an alternative instead?
>>
>> In NixOS, we disable MODULE_SIG by default (because we value
>> reproducibility over having module signatures). Enabling
>> MODULE_HASHES on systems that do not need to load out-of-tree
>> modules would be a good step forward.
>>
> 
> Mentioning this in the cover letter will also be good. So two
> distros seemt to want this.

I'm aware that folks from the reproducible build community have been
interested in this functionality [1, 2].

Some people at SUSE have been eyeing this as well. I've let them know
about this series. It would help with the mentioned build
reproducibility and from what I understood, it should also avoid in SUSE
case some bottlenecks with HSM needing to sign all modules.

I agree that we should make sure that whatever ends up added is
something that some distributions actually check it works for them and
they intend to use it.

From the SUSE side, I can also support that the feature should work
seamlessly with the current MODULE_SIG.

[1] https://lists.reproducible-builds.org/pipermail/rb-general/2024-September/003530.html
[2] https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/merge_requests/1

-- 
Thanks,
Petr

