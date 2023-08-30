Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02178DC6F
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjH3Sps (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 14:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbjH3QvJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 12:51:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCED719A
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2023 09:51:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a3aa99bcdso7972707a12.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2023 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693414264; x=1694019064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cL4XVu3TuX+EzQAzzotoYtukO16KJle9C8DBmOifN0M=;
        b=DaPT8lpr99dNx/gvZOYl5m98sppW1WQ7wHx1PTuQJ4S1lposTslokfT40C6px5Tvgh
         GSN39q4qesNFrxrDt3JsAzu8njHq/zrkkyVhCPf8eeR/nZtN/O4afqaS7gG0EX+yiL02
         pofd4rjeGO3feIfX4PmMECn/f7Emq7J/3G5uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693414264; x=1694019064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL4XVu3TuX+EzQAzzotoYtukO16KJle9C8DBmOifN0M=;
        b=OijARP/m09Q8hdHNWay+PdVePvI0vqRs7pqW0wpP87abYYH+uYW/4AYD1CrjvwJ2jm
         V5i6RmXkk4SMVxUUn+GVxvlImE8lmM5xjMQ3b2m/nYcrNQXqBTcW2WQdcbefrANIJHQa
         USPVOxuH4VhYT91iiwkc0lhfsaD0QiSOghM2vczXfDNIYzpeR2YR2yk5VxV4k9ZAxU/u
         +dxhGjcQKANaB+043en8K+IM99lDC2vf5CxMMKaTnF+BYllspUMtv870AaJ2CqwjHAM/
         bWBZwsMVXcsDZGIDwkf7+ARKqGycQIed0WWCk55Wlm5wCziWmO6Hiu+Jir/ZB+ditriY
         yXxg==
X-Gm-Message-State: AOJu0YxPLsjhNxJEXbb/kf1C8TcHVjjDrEN4IoTnSf72RPBqKjhLRQNQ
        +psQoAz/Nl8HGlzMOhNRjfYkviIOZ+/ZSRMG3j2ulC9Q
X-Google-Smtp-Source: AGHT+IEyBTNJNAJt3QNFBaOQFIjCuq7pTrOsPm2IbQ/vLO650riU4ePCaawIJOWSHetnwnlawk+8uQ==
X-Received: by 2002:a05:6402:1482:b0:523:1095:6980 with SMTP id e2-20020a056402148200b0052310956980mr2347490edv.20.1693414264203;
        Wed, 30 Aug 2023 09:51:04 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0052544bca116sm6951015edr.13.2023.08.30.09.51.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:51:03 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99c1f6f3884so736528866b.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2023 09:51:03 -0700 (PDT)
X-Received: by 2002:a17:907:b68c:b0:9a1:bd82:de24 with SMTP id
 vm12-20020a170907b68c00b009a1bd82de24mr1743932ejc.12.1693414263316; Wed, 30
 Aug 2023 09:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com>
In-Reply-To: <20230830140315.2666490-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 09:50:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5s3JbYKd4SsCsDQ8RxCEKXGG-d61Ab9hOev9wnyGbHg@mail.gmail.com>
Message-ID: <CAHk-=wh5s3JbYKd4SsCsDQ8RxCEKXGG-d61Ab9hOev9wnyGbHg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 30 Aug 2023 at 07:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Hand-rolled mov loops executing in this case are quite pessimal compared
> to rep movsq for bigger sizes. While the upper limit depends on uarch,
> everyone is well south of 1KB AFAICS and sizes bigger than that are
> common.
>
> While technically ancient CPUs may be suffering from rep usage, gcc has
> been emitting it for years all over kernel code, so I don't think this
> is a legitimate concern.
>
> Sample result from read1_processes from will-it-scale (4KB reads/s):
> before: 1507021
> after:  1721828 (+14%)

Ok, patch looks fine to me now.

So I applied this directly to my tree, since I was the one doing the
x86 memcpy cleanups that removed the REP_GOOD hackery anyway.

              Linus
