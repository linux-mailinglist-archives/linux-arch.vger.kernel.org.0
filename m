Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15C6EC37
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfGSVrz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 17:47:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43609 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGSVrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 17:47:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so32593147qto.10
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2019 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HwGl0g54Inu2dbHSvUTjnjBXO/l4Rj8T8rMQLiptqQ=;
        b=S7NSIgwsEeldpe7xNOPbAeT15AiLbQlHN5SkR4PFzKcUrnCuWgDYdIi6GFqO4QmLGa
         O3p+XMs7pGfbtW2YdDsMea5DMxRqTA0bXKv+rqrhuC0PazCUwnTPKItm7cicOl6tC8b9
         2QqkNbWkQoXW/Yhtza4WUxK82UPmCnyz5wZk/cUU5Dknmzxb5fM3F1KitYTurr36JSYp
         NIfODJan61L2wwW69zYnwz0MTnkdPy6fPggNtG8vSFnXIyyv9z6P876+ZRoVBRFWeWOB
         2lnMzlNyRswXmzb10WlEo7w5xTHFZPGwALYR0LUh6qVntZKzGMnS/8MhxrV0oAjyjNwB
         3mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HwGl0g54Inu2dbHSvUTjnjBXO/l4Rj8T8rMQLiptqQ=;
        b=KZcZCLeIPFPtyzCYt4rBjeX2JWWix68QXvB52bZFtxFQMVp0DhIAXBgTWalULlFppp
         alsUlhlbeNQbIiDGKk83ZsDUJqJBNI5nR2cOihxT+obprm0mvErBwxGBf1GCVr0WsEk2
         37qHfzocXsO1NiHCakXDJ3sIgk17V8XTg7PeUeNK06XFMmfBc+OvzYBFXpLpPeKRJkFy
         Y+LJCgAk7TbZFeuSwuyNzouw+owqMEqKkPYCwyuqbcRjR6TpMUeGgLSdoe6cjOmXZ8fj
         TPFwHAD6hE6sS30bZ2DzzlHPGOh1goRkXRKnlFqxT42nyyCtMwJccWTO22XefE+V+7/p
         /QVA==
X-Gm-Message-State: APjAAAW5G7EPb4gS5+vemq7wcAnY52LRUn5Ex9aFKW5mtmXDq1UaLMx6
        TpWaf/rEH+WeS1S8pJjsO9BgtQ==
X-Google-Smtp-Source: APXvYqw2RzqAIIsmVz3/U7pX3OR2QqfQEoLGKDqx/8DZeQgj2h2q3hME8vDfKuW76z7cPpa6BS23kA==
X-Received: by 2002:ac8:394b:: with SMTP id t11mr38419556qtb.286.1563572874284;
        Fri, 19 Jul 2019 14:47:54 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z1sm15011603qke.122.2019.07.19.14.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 14:47:53 -0700 (PDT)
Message-ID: <1563572871.11067.2.camel@lca.pw>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From:   Qian Cai <cai@lca.pw>
To:     David Miller <davem@davemloft.net>
Cc:     morbo@google.com, ndesaulniers@google.com, jyknight@google.com,
        sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com
Date:   Fri, 19 Jul 2019 17:47:51 -0400
In-Reply-To: <20190718.162928.124906203979938369.davem@davemloft.net>
References: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
         <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
         <75B428FC-734C-4B15-B1A7-A3FC5F9F2FE5@lca.pw>
         <20190718.162928.124906203979938369.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-07-18 at 16:29 -0700, David Miller wrote:
> From: Qian Cai <cai@lca.pw>
> Date: Thu, 18 Jul 2019 19:26:47 -0400
> 
> > 
> > 
> >> On Jul 18, 2019, at 5:21 PM, Bill Wendling <morbo@google.com> wrote:
> >> 
> >> [My previous response was marked as spam...]
> >> 
> >> Top-of-tree clang says that it's const:
> >> 
> >> $ gcc a.c -O2 && ./a.out
> >> a is a const.
> >> 
> >> $ clang a.c -O2 && ./a.out
> >> a is a const.
> > 
> > 
> > I used clang-7.0.1. So, this is getting worse where both GCC and clang will
> start to suffer the
> > same problem.
> 
> Then rewrite the module parameter macros such that the non-constness
> is evident to all compilers regardless of version.
> 
> That is the place to fix this, otherwise we will just be adding hacks
> all over the place rather than in just one spot.

The problem is that when the compiler is compiling be_main.o, it has no
knowledge about what is going to happen in load_module().  The compiler can only
see that a "const struct kernel_param_ops" "__param_ops_rx_frag_size" at the
time with

__param_ops_rx_frag_size.arg = &rx_frag_size

but only in load_module()->parse_args()->parse_one()->param_set_ushort(), it
changes "__param_ops_rx_frag_size.arg" which in-turn changes the value
of "rx_frag_size".
