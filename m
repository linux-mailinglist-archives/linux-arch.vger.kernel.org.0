Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD5549BE3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbiFMSl4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiFMSlg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 14:41:36 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E802527FC1;
        Mon, 13 Jun 2022 08:22:43 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id a9so4535941qvt.6;
        Mon, 13 Jun 2022 08:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcugiPICJLPzQVbJaMNvRLiNwKZci/LNeFue+3qV07c=;
        b=QOxSPO2OkOZkyfuTU+urLlI0TBuGEyVYL31+208ARrWq7zyVEEqhz4L7oUEAITV2VP
         QruLsgFZLjUYyQJeRz1MdYqqidC+VXO1hv+GNOan0PwdVJ7hl9El05BVtnI3St24FDMI
         ceLQ/xmTxMDqay/tQf1dJ5u+1ZEuicjO/QJxySq/z8auIRvgZJHp/hCq9lpYlVaUXvnT
         Ji4GzcM7EsVXDBVyoqGLUgDmhD3Y77bWhEnUmM5cDbKERo5TVbc5k3VgQOx2ZKcMI9kd
         JtpJN5k/tPAqu6egujEWzM+0UyEn3vIUOmWqVFr6Kekg1C1aDgAA5QdGImwsrQvT83xG
         C/oA==
X-Gm-Message-State: AJIora9T9io/VxswjBbeeoUrR0OO7OFyTpN9GIIBx+khJ8bKCuLEaAwf
        fp3IxZPw7RrZDxt3S9Q0/OYvytzLjBKY1Q==
X-Google-Smtp-Source: AGRyM1tR23QUPLSYmCAd7BQK6XX/kwgM+nwgjzZ6OZZ6JQ76t/Z0rwIfTCBiFtqIB/RLnwSKOCTAgg==
X-Received: by 2002:a05:6214:623:b0:46b:9512:b355 with SMTP id a3-20020a056214062300b0046b9512b355mr172620qvx.8.1655133762571;
        Mon, 13 Jun 2022 08:22:42 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w2-20020a05622a134200b003051ba1f8bcsm5095399qtk.15.2022.06.13.08.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:22:42 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id k2so10427683ybj.3;
        Mon, 13 Jun 2022 08:22:41 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr55080ybg.365.1655133761358; Mon, 13 Jun
 2022 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <CAMuHMdUZCaPN2B6bvmja9rDm3qCc4mYYAOSEB2W0R0pws8peqw@mail.gmail.com> <20220613142645.1176423-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220613142645.1176423-1-alexandr.lobakin@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jun 2022 17:22:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVayS6hV3CWW6FS-1cQKoGTCDxgVhZVPSyBMvJHBxVwJA@mail.gmail.com>
Message-ID: <CAMuHMdVayS6hV3CWW6FS-1cQKoGTCDxgVhZVPSyBMvJHBxVwJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] bitops: let optimize out non-atomic bitops on
 compile-time constants
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Olek,

On Mon, Jun 13, 2022 at 4:28 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Fri, Jun 10, 2022 at 1:35 PM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > On m68k, using gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04), this
> > blows up immediately with:
>
> Yeah I saw the kernel bot report already, sorry for that >_< Fixed
> in v3 already, will send in 1-2 days.

Is it simple to fix?
I might be able to give the fixed v2 a try before that.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
