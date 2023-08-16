Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D656077DB51
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbjHPHlu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 16 Aug 2023 03:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbjHPHld (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 03:41:33 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A92684;
        Wed, 16 Aug 2023 00:41:31 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-645181e1eaeso23771586d6.1;
        Wed, 16 Aug 2023 00:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692171690; x=1692776490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkTNstwI73s4YFo3/SQhtE6/OXSa9yBSjbdY7mJiIyI=;
        b=ZWCc9ScPiCC2xQyiN64sCepltSBLSmwB2j6GdgGlYkZ/L5skdvQ8mlv6OxJjZRkOIl
         LQEmjzqQV4iG4/N1fR2gI60Xm5B7khwigOAvKcAZjKk5qPLoMdK6uVUl6A4coaAZ2vug
         teo0vPrNe3qIp0vX2FA5mvVAsUJigWldcBojXeEyDg+Ok4+beC2zkqWNaG6TsDdhNL16
         o9KjKA4Eefb5/6BnOR6rbV7Eha2ups0Yz/1WFK4UuJUhvOBgufPCJiJ24/M1O4rHfoXl
         dbKbfeD3Cg4TSpUBJ/m7OflrTD4efP6XMic4kWKdcui+so21hGebk9BXPSdg5g0tgeky
         xGuA==
X-Gm-Message-State: AOJu0Ywl03oNue8j2JOGoehXptd714RTa2adC8zXvVvb+lg5tvi2h4wO
        DNJwWubeAZ8X2knwP5L3B/ackTrzVMXtgQ==
X-Google-Smtp-Source: AGHT+IHsLPuRqSkelDdJbL57KS+jFzD5VBtQSK0+r7VuMrg8naBsJnbZ0+fipciPzWuvba87SGrfBw==
X-Received: by 2002:a0c:f2c4:0:b0:628:74d6:ba89 with SMTP id c4-20020a0cf2c4000000b0062874d6ba89mr1000338qvm.60.1692171690515;
        Wed, 16 Aug 2023 00:41:30 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id o20-20020a0ccb14000000b0063c6c7f4b92sm4698938qvk.1.2023.08.16.00.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 00:41:28 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76cb0d2fc9cso423004885a.2;
        Wed, 16 Aug 2023 00:41:28 -0700 (PDT)
X-Received: by 2002:a05:620a:3711:b0:76c:5715:b4a3 with SMTP id
 de17-20020a05620a371100b0076c5715b4a3mr1484328qkb.13.1692171688197; Wed, 16
 Aug 2023 00:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230816055010.31534-1-rdunlap@infradead.org>
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 09:41:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF0LseSGK6=aodXaoK9D16mxok4DDRs=gKoGox8k6zjg@mail.gmail.com>
Message-ID: <CAMuHMdWF0LseSGK6=aodXaoK9D16mxok4DDRs=gKoGox8k6zjg@mail.gmail.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy,

On Wed, Aug 16, 2023 at 7:50 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Makes perfect sense to me.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
