Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890B02C2D0B
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbgKXQgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 11:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390374AbgKXQgt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 11:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606235808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qViGPvAp3Bdb6AOjvlouT/dVyBQzwDGsvBv6zenTU0=;
        b=dAF24XkatYRVtQUW8jf1zyQHr7l3u3oN3hV56Uvejrea+bh6BAQpoDqvbXCUkTzN3as3R9
        bwtzty9OTqyyIYxam3MFulujwXY+tee5Im03J7CTgfzPjal5i1OGsQKBQSbdCpRzHjoPIO
        jYwPFDopN0rp7mQZLtEGijWc5e/IBNI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-8d3pl90SM9uC0I4JspuX7w-1; Tue, 24 Nov 2020 11:36:46 -0500
X-MC-Unique: 8d3pl90SM9uC0I4JspuX7w-1
Received: by mail-qk1-f199.google.com with SMTP id s9so17684937qks.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2020 08:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3qViGPvAp3Bdb6AOjvlouT/dVyBQzwDGsvBv6zenTU0=;
        b=ecA24hdXTvx4EqnS/Nx8twdv32A1hgvPLXpnnDj78l7gZOA2rvuRyMD6FtEFlqYqR9
         7/HlV/zWd8tgkj8X86Df0aVoYSu08C87Fk+EY+nZZmQ5Sr3cJkc08Kn7Z++Zw1mimJKU
         UiFz2BmmVqSe3BbXgXbsehFcgQ9OzAUCtl++pD0SvToGe42ehxhsjKUqrlJnxujUshvk
         duQorVwH0aRVfmkMJe7lN64YmbnarQ1y02N31VPswpnYp0omi/Y23O4SahkO9y+P53xp
         SIcuKDrmRQj6PcAr7M2yKDm3sYuzW2QDz7eKKiWdih7Y0VmF7jOgidds6mklUyd9eZd/
         VBBw==
X-Gm-Message-State: AOAM530EqdNFeJy6WMaJLyzmr6JlcX8GZBNz6rIaszm1wZe0FnH6P1/r
        V1JcW+NaVxJXwkEMu5d7JnsbFWKI7EJS+bhMe7cf2DEUFL9UyR05Eereh7PdFDzVEj8jNxO6Rbz
        wAziD4JCXIpjSAbpM7D6FiQ==
X-Received: by 2002:a37:6892:: with SMTP id d140mr5265879qkc.200.1606235806340;
        Tue, 24 Nov 2020 08:36:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzP/zq72cvnSAWEVDqTAda07UHdS5aRMF2LrjfClGVhHpVLSq+wwWTS4eIddRlosB2VneKCw==
X-Received: by 2002:a37:6892:: with SMTP id d140mr5265862qkc.200.1606235806104;
        Tue, 24 Nov 2020 08:36:46 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x19sm10252911qtr.65.2020.11.24.08.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 08:36:45 -0800 (PST)
Subject: Re: [PATCH v5 0/9] "Task_isolation" mode
To:     Alex Belits <abelits@marvell.com>,
        "nitesh@redhat.com" <nitesh@redhat.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Cc:     Prasun Kapoor <pkapoor@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "leon@sidebranch.com" <leon@sidebranch.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8d887e59ca713726f4fcb25a316e1e932b02823e.camel@marvell.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b0e7afd3-4c11-c8f3-834b-699c20dbdd90@redhat.com>
Date:   Tue, 24 Nov 2020 08:36:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8d887e59ca713726f4fcb25a316e1e932b02823e.camel@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 11/23/20 9:42 AM, Alex Belits wrote:
> This is an update of task isolation work that was originally done by
> Chris Metcalf <cmetcalf@mellanox.com> and maintained by him until
> November 2017. It is adapted to the current kernel and cleaned up to
> implement its functionality in a more complete and cleaner manner.

I am having problems applying the patchset to today's linux-next.

Which kernel should I be using ?

Thanks,

Tom

