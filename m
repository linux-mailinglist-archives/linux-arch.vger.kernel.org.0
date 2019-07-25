Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135EB743E2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2019 05:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbfGYDWS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jul 2019 23:22:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42631 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387761AbfGYDWR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jul 2019 23:22:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id h18so47696629qtm.9
        for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2019 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ShvDC3DRx289o2CON/ZG1R7PVjHyyeC6C/VPB/VWoE=;
        b=YctGd6NEPdOBJvo3F1CLLFeQj0m7HIaBITggi2rmoo558fyoyRuTogrfhp+FUugY+G
         AYa0D/zmlxgpbeUoLkQx4Sw28wwBVVOouaKJACoyg9C6dvsfYsk2zWQiRIBbp9b4VSIQ
         ORmD7aCRJNbmpDJiwzT46X+gpHlYHnPB+qYgkJ1DlIdz/fAO55B9dSW4qQ8lqMkg/bzZ
         Y9GEfdzPUqyKUonLr3PpxKGt5JWfaSPwl9PPTYFF86sV0eoWTBwuoiLLpH4jXVYoIfhU
         tvzVaUDEOmUwMfkn703ghLk4iRNriXPpVRhWCRZP7TP9q8lE/cIrfMpERZzHZr9Azil8
         itGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ShvDC3DRx289o2CON/ZG1R7PVjHyyeC6C/VPB/VWoE=;
        b=cwwAn7BZXkP0WMcmeXwFLcT3ErUYzUzGgXXEKaZguFvgSaLlHnOD6nOOPf/3wmJRPn
         3cOky6ZlHTviB6rXiMXzA6ZVpoBIcVNkEOwndohtEoch1GusdGVS7RHz5nu5AN/tvghF
         XAvl4IKcUK2Okf3NGBcEwwYPfme3lSvjemv6+6HJ/2e6XRPIMd325r5xqH1nPrWa1lg3
         o9NB6cOLMumYkpMCP3sLL4J2o6w4JT7DLSvwOE1XYVGWNs42a6k3EWRCBSoK+Lxne03X
         kOLWXELKnX9tL/LOYXBhSBarwcpqenUSS2FNHSVaTxakQtzNUcTy8s7TgoC689A2/4C0
         vAxA==
X-Gm-Message-State: APjAAAV7bTn60sB8k++XCHyQM/Yyl63hOdy2jb8C7yfubj2kfKJbGl06
        gxHoVZBgXz+OkBBjzP9o5IgSow==
X-Google-Smtp-Source: APXvYqxL2A7Dd39QkyKn10UQ1uUAQP59dYx3GoLGtvNWpCctFtJgncxRvhOaoX4tEqTZwcfh3OSJzg==
X-Received: by 2002:a0c:b159:: with SMTP id r25mr60129104qvc.219.1564024936607;
        Wed, 24 Jul 2019 20:22:16 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r189sm22155341qkc.60.2019.07.24.20.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 20:22:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <14026.1564004959@warthog.procyon.org.uk>
Date:   Wed, 24 Jul 2019 23:22:14 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Jelinek <jakub@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, morbo@google.com,
        jyknight@google.com, natechancellor@gmail.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <209DCEDB-98B4-4D57-8F2C-0B8F0406B5CB@lca.pw>
References: <1563993952.11067.15.camel@lca.pw>
 <1563914986-26502-1-git-send-email-cai@lca.pw>
 <31573.1563954571@warthog.procyon.org.uk>
 <14026.1564004959@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jul 24, 2019, at 5:49 PM, David Howells <dhowells@redhat.com> wrote:
> 
> Qian Cai <cai@lca.pw> wrote:
> 
>> I have GCC 8.2.1 which works fine.
> 
> But you need to check the minimum version, i.e. 4.6:
> 
> 	#if GCC_VERSION < 40600
> 

I did check gcc version 4.1.2 20080704 and it works fine.

