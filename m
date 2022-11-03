Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB76617405
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 03:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKCCJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 22:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKCCJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 22:09:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8795F69;
        Wed,  2 Nov 2022 19:09:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m204so635002oib.6;
        Wed, 02 Nov 2022 19:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc7qdI65dRfF6g5MHViHcl74Y3pPB9QtXbMbAM7xgik=;
        b=WFugCmbVmKfj0ksu3w1ifhjHhSAkcHZ8E/o6PbEmyOursrGAEjGfNcUw+zNkozY6oz
         tdjp+Zi8GV1+/Z5gqMjVxQOYmGPkokQzDGBkcJ2anuWVlZdiyEQIuep7JI9Y2G4qy98n
         /uMvlkwPOEmlAb7h8EjlqEh52PdaYabdg9lYbs7o68dOBv7suJL7QGNZ8ejttl+utzgs
         Ut2k0Ud8hnAjb+M1uKT7YDqs2z/7EkG1H4v2uTrfov+P/t+iqB53zUvm1v2hfQAy4PNQ
         wVuu6yWE3tKh+fG14otW+LtFiaof8LNt79zOLvrqYOyG+8Xs/wx4VLp8FpzLT1ucbRoL
         6MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc7qdI65dRfF6g5MHViHcl74Y3pPB9QtXbMbAM7xgik=;
        b=Ruv+ptkotxhI+VTSy2Oe7V6z8mGURwS4/DIfUx5qz7eFg65pjeosKMNy3D9ZwJLjEu
         AGfyo0OWzZAscrvQfEcp7pS74eqr48F5VxxapQd8TMdcW1mLiveNX9+/Th+EtZWhL/IA
         eHhLJBCme89FlQ6z3PgFYb3R4na2aW1eUSwxd+Oex0YwqtciGrjOm3FypRs+Y3+BYsXp
         h1VvUHJxNF+/xsLFgpeOBDI7OenvaDWsNzQEoJQ7A/VlrN4+eOFTMu5dJVhJCPCsqlzQ
         W/inofpCsfSRVW5agRPcN8mcvhkrtL0wLrvhlI5K/+aPszBZ4ABAY9n8S7rsO2K/JVss
         beMg==
X-Gm-Message-State: ACrzQf0ehVew0iiAGHKqi1WDYX37KqxNL7vbbT6M9OelyhsBgknmOpIP
        Q0W7agEX/MZT+Zyn+HzY0Y1fVz8MGMA=
X-Google-Smtp-Source: AMsMyM6qVPMpqFP5351ROoP6w/QFaiNR8cFsPKh275zHkxOkbuWaCUUpOI2CTVjgQwYmGOsg2bsHEA==
X-Received: by 2002:aca:ded7:0:b0:359:dee9:7809 with SMTP id v206-20020acaded7000000b00359dee97809mr14749056oig.1.1667441389459;
        Wed, 02 Nov 2022 19:09:49 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q16-20020a056870e61000b00136c20b1c59sm6842170oag.43.2022.11.02.19.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:09:49 -0700 (PDT)
Date:   Wed, 2 Nov 2022 19:09:48 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/3] bitmap: optimize small_const path for
Message-ID: <Y2Mi7PYO4ihnA+Pb@yury-laptop>
References: <20221027043810.350460-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027043810.350460-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ping?

On Wed, Oct 26, 2022 at 09:38:07PM -0700, Yury Norov wrote:
> Make all inline bitmap functions __always_inline to ensure that
> small_const optimization is always possible, and improve on it for
> find_next_bit() and friends.
> 
> Yury Norov (3):
>   bitmap: switch from inline to __always_inline
>   bitmap: improve small_const case for find_next() functions
>   bitmap: add tests for find_next_bit()
> 
>  include/asm-generic/bitsperlong.h |  12 +++
>  include/linux/bitmap.h            |  46 +++++-----
>  include/linux/cpumask.h           | 144 +++++++++++++++---------------
>  include/linux/find.h              |  85 ++++++++----------
>  include/linux/nodemask.h          |  86 +++++++++---------
>  lib/test_bitmap.c                 |  23 ++++-
>  6 files changed, 208 insertions(+), 188 deletions(-)
> 
> -- 
> 2.34.1
