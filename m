Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60303DA5F1
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhG2OKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 10:10:11 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39914 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbhG2OHL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 10:07:11 -0400
Received: by mail-wr1-f42.google.com with SMTP id b11so1775955wrx.6;
        Thu, 29 Jul 2021 07:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8LofI00GAwLkUAnxAUd4xKumAPYSByZWAAynmglCQoo=;
        b=q1b6B0HkXqq6P43gcgLMIHU6Ks/hfTA1OMSMPH/UvlpedIaGJAImLN1++8tF3vszIc
         1fY1Yqn1VD5cJ4ZAzpmWud+YZENUbwq1cgW6DW7lHw3u9DNk7mnc8kCqOQHjEetNDGVC
         23Z7TGRNnw2F/Q3vnOKKIAyRcVhm9iSkD4hSqOdyZYoUgJXifZjOhlroahvj7+TtYlYE
         20vVujKaucgBN0DjgHsFJmRGfxCe6oKBQZ2jwRNufwy9HuKTnkkz+6DDT8SE6nnHf01U
         Wk6H5n2rXpgi1XDhcSo1k8v90xEaInhQaJmtT4LtnkTyemjb4cL+LHaIvVARXMM1Remi
         nNNw==
X-Gm-Message-State: AOAM530HYBk3HE/8WnShK1hYGAWrQ42Hn1IJsA+L9riZaoJIDLvM6jAt
        0SHO1UexznYr6J2SvnyCuP0=
X-Google-Smtp-Source: ABdhPJzyQQcNlTQOQAYqPAwVB0LNrL0j3MkejU/yVyGKgSEKW5TBNC+ecp+5xsLrh6HC+pPYI3mKGA==
X-Received: by 2002:a5d:5750:: with SMTP id q16mr5182030wrw.9.1627567627396;
        Thu, 29 Jul 2021 07:07:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u2sm10170996wmm.37.2021.07.29.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:07:06 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:07:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/hyperv: Fix struct hv_message_header ordering
Message-ID: <20210729140705.wj5tokeq6lkxm2yy@liuwe-devbox-debian-v2>
References: <20210729133702.11383-1-sidcha@amazon.de>
 <87eebh9qhd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eebh9qhd.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 03:52:46PM +0200, Vitaly Kuznetsov wrote:
> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
> 
> > According to Hyper-V TLFS Version 6.0b, struct hv_message_header members
> > should be defined in the order:
> >
> > 	message_type, reserved, message_flags, payload_size
> >
> > but we have it defined in the order:
> >
> > 	message_type, payload_size, message_flags, reserved
> >
> > that is, the payload_size and reserved members swapped. 
> 
> Indeed,
> 
> typedef struct
> {
> 	HV_MESSAGE_TYPE MessageType;
> 	UINT16 Reserved;
> 	HV_MESSAGE_FLAGS MessageFlags;
> 	UINT8 PayloadSize;
> 	union
> 	{
> 		UINT64 OriginationId;
> 		HV_PARTITION_ID Sender;
> 		HV_PORT_ID Port;
> 	};
> } HV_MESSAGE_HEADER;

Well. I think TLFS is wrong. Let me ask around.

Wei.
