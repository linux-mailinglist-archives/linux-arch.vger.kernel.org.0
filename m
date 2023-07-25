Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8204760B9D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjGYH1B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 25 Jul 2023 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjGYH00 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 03:26:26 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C010F4;
        Tue, 25 Jul 2023 00:23:07 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5701eaf0d04so61424387b3.2;
        Tue, 25 Jul 2023 00:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269787; x=1690874587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr/WmELX7sIB4KKGXjN39nbmOdcGP5Da53YhJ8tvtVs=;
        b=KEqD/570LdsTacdTP8FWbn7qfAgwYyEDykHmAvxEQlXza2Z6e/S5mQnZ06uGA/X833
         0ql+vb5rjs8PwNmishK6rIVggbooU9bTtQd9ggZKyPc/Ezz8hqRGtTWuMwfoqe46Iuyg
         VIDA0KGEatEvfIJsZXErNt2fBy/Y2qHyYZALF9BW5ex4qWByBtv3z88N6UBpDqQPs0dH
         Vv5g+30msf31Uf4w+m8/kZMIYdLjKiB1wEHHYV+tEzHA0KRJE5QHCmgs+cTFzcgSkrjL
         6hYxLVzld5uvWlgNevfJ5jqHsl20gpLFLsCsZNengP6ZaKiyyQJQ2zVWZejxt1Or5LlR
         SdEw==
X-Gm-Message-State: ABy/qLYaxs/EFNbmJz1sNiNHBsrEml3pYGYkJDiWZuhKrNZUliFl34iE
        0EbISDZokOq+TxuW5Btr+cV1KUe58MJydw==
X-Google-Smtp-Source: APBJJlGvQtJ6ostEosIB9oh1Ggu+3KD7gL0trvs76YtA7gmHq7LbMsdcwfD61TPeSfTdwVgIF++XAw==
X-Received: by 2002:a0d:f181:0:b0:577:3561:8a81 with SMTP id a123-20020a0df181000000b0057735618a81mr9869634ywf.22.1690269787006;
        Tue, 25 Jul 2023 00:23:07 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id e126-20020a0df584000000b005773afca47bsm3372715ywf.27.2023.07.25.00.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:23:06 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d0548cf861aso4130822276.3;
        Tue, 25 Jul 2023 00:23:05 -0700 (PDT)
X-Received: by 2002:a05:6902:85:b0:c86:5651:aefa with SMTP id
 h5-20020a056902008500b00c865651aefamr9272919ybs.10.1690269784970; Tue, 25 Jul
 2023 00:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230721102237.268073801@infradead.org> <20230721105744.090372309@infradead.org>
In-Reply-To: <20230721105744.090372309@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:22:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbWeTbygVRHZRnG9eXdHu+t6bNYMZoW4g7Fp41YO7JrQ@mail.gmail.com>
Message-ID: <CAMuHMdXbWeTbygVRHZRnG9eXdHu+t6bNYMZoW4g7Fp41YO7JrQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] futex: Add sys_futex_wait()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 1:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> To complement sys_futex_waitv()/wake(), add sys_futex_wait(). This
> syscall implements what was previously known as FUTEX_WAIT_BITSET
> except it uses 'unsigned long' for the value and bitmask arguments,
> takes timespec and clockid_t arguments for the absolute timeout and
> uses FUTEX2 flags.
>
> The 'unsigned long' allows FUTEX2_64 on 64bit platforms.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  arch/m68k/kernel/syscalls/syscall.tbl       |    1

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
