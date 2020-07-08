Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC7217E7A
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 06:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgGHEi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 00:38:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40703 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgGHEi0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 00:38:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id x11so17644150plo.7;
        Tue, 07 Jul 2020 21:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLqyPrHmkwwskxepcX7hcpAy9KCQ3ceDS+STlZ/U0Zo=;
        b=s1CMpuWz3Qqa9b1izEWrOkElyZCNOU9qFgjvI898V5bQ+IoXGBbMwIO+DoksmXmtx5
         vDUjWBgH4mppktjbl4m+M/gbjakjQsBFDm/P9tT1DD4073FlW/p8vdo44UCEGVs79qJU
         diwHpIpsUkLXX6Y8u3hXjaHn1iU1wiyetd3w23yk47x0tAQlXkxjLO0nan7Ha7nvEsa7
         KnKu0C8vhsWqXdvjIRFUUIKs+Nu4m9nTdUv30lm5J3NTCFvvv8D2UmxwqkD/jUV/cQeE
         x8FjsstqhIvKjQCDcdS+QecEWe+OnSkilb+mpRBdSstST+L5Zou70PNCfW/KYB/u/gey
         GEag==
X-Gm-Message-State: AOAM53264Ip0SXINTaGAnRCk8PshnUW8oooTyOWyxQ0YfdAAgogl44fa
        97lQH4FLkitD+5oWD94lcqs=
X-Google-Smtp-Source: ABdhPJzQZBDpIZw9iAzqNJSgkNYuYBasQcAK531ZK3GOkmKLjjDjlLx8Uewlh2xjKVlV5/alkiMSig==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr7680022pjy.179.1594183105448;
        Tue, 07 Jul 2020 21:38:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e5sm3979787pjy.26.2020.07.07.21.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 21:38:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C7031400DB; Wed,  8 Jul 2020 04:38:23 +0000 (UTC)
Date:   Wed, 8 Jul 2020 04:38:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 08/12] init: main: add KUnit to kernel init
Message-ID: <20200708043823.GZ4332@42.do-not-panic.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-9-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:13PM -0700, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

The commit log does not explain *why*.

> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
