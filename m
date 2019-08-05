Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF60981FAD
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2019 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfHEPBK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Aug 2019 11:01:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42108 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfHEPBG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 11:01:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so39770684pff.9;
        Mon, 05 Aug 2019 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWknOm3Weo65hoQxD0OMyaPHcUcXcORCl61LnaMhBHs=;
        b=U9ztI/gIE3rGmpMLb6h3XduLr5I+Jmc3UXd6RwE+BsEiCBgWvOt8SESPCa/yaNpeDg
         5NLEhf8LkYXjUMpGmH7w3OKGVBjkym5nFDPSsH6FzaY3wTyO++zo3IZObB3PoayJKcwe
         9Zp5I7ScGw174YsesmASgP+QjMaJwbtjBQ0WJnPUn+2MHgxkqDxMHjiDKlA/ujO0XTUE
         Gro84k7vmLDxHUaQ5rL12Y8vo3vJCxvBRykdfxXE6jmVX1kXxdKusvEtir5857vMn2Oz
         2/3wAyNciJRXhpT4P9zFNgmFKtDnG7l0/62B7QRKxxlPvowtJtZAxmyKK9Wgck/cHB3a
         qBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWknOm3Weo65hoQxD0OMyaPHcUcXcORCl61LnaMhBHs=;
        b=jqPUrZx8qfC99w/M7p91shNZE1r1QGOFJvOdVyRdGoErLsZYI5rYmwL9owe+MlzUVo
         zXjal4lb2qmOQFoGfY7TBIT3rYblXotO7WimcRLS/N4JVjVxVJFlv/tJGTPVUvoObPes
         CMr1Ydf7Nwg6vb1G+2TBO0F5aNB7rVBt9MuKdhclABF/QWadWyVbsMZr05gKvdVcB7kD
         UDPrCj9wes+Lu5BT/N12RbEaXa8SrcJ5n31HtnXlmRJ0wdlLP1H2QnGy5aAuK28+IlRq
         BYWLKcIpzyUt+r9jJ3PQOGwWVzjgCOCmaHPEGlBfK90qbQTRtcCJMKx/irNVaV6ejieK
         RhkQ==
X-Gm-Message-State: APjAAAXKttwU5xcx1gLlkIjTVJkaBH9XhKLX1WGYwVHEh/ye+NR+F04A
        n1sajOGi4NTqkfTjQNzUQOU=
X-Google-Smtp-Source: APXvYqzLGQLInXt1y4PDIZrIFJHvmzApxJcFTFguBOSpoAxiH3S7HxsR87mHnbYleSrFAUxeshIF0Q==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr75897672pfr.38.1565017265795;
        Mon, 05 Aug 2019 08:01:05 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b26sm93700927pfo.129.2019.08.05.08.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 08:01:05 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
Date:   Tue, 6 Aug 2019 00:01:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805121517.4734-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon,  5 Aug 2019 14:15:17 +0200, Andrea Parri wrote:
> My @amarulasolutions.com address stopped working this July, so update
> to my @gmail.com address where you'll still be able to reach me.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Andrea,

Why don't you also add an entry in .mailmap as Will did in commit
c584b1202f2d ("MAINTAINERS: Update my email address to use @kernel.org")?

        Thanks, Akira

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6426db5198f05..527317026492f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9326,7 +9326,7 @@ F:	drivers/misc/lkdtm/*
>  
>  LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
>  M:	Alan Stern <stern@rowland.harvard.edu>
> -M:	Andrea Parri <andrea.parri@amarulasolutions.com>
> +M:	Andrea Parri <parri.andrea@gmail.com>
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Boqun Feng <boqun.feng@gmail.com>
> 

