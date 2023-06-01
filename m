Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E537194A0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjFAHqn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 1 Jun 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjFAHol (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 03:44:41 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7321719;
        Thu,  1 Jun 2023 00:42:28 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-75b132ad421so57352785a.1;
        Thu, 01 Jun 2023 00:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605347; x=1688197347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC4AZRVcHnRKNLMlbDCAYeJz9LlsudAe96MnAggdWqk=;
        b=lweRgBRXziI1Oh3WT3s2jgEpB8Xy7fbVccJ+O9kKZW4vrf93YAuXJu/7cnccsMKHKX
         dnfvu7OAd/Y7oC1GSsJ35zqdl2WzKWVPbXyf6YdsSAHC8F70vgnJrp1CWjEq7Jstenua
         iiH2yRzpmYdZPqB5bab+y5UQonbdPh8tRJWNH658aZciY20yt0GMS3gpi78KqPy6n945
         M5G9Fa95Rf1JdEYAG1Q8JxCFiWrKvHOQc7Jrip/D2zC2Q7PpT5ja8JdUrHrHbP5gsWJ8
         /HxqRYtLW9tECnGCsvK6+nxCc0oUnI6jmUulMBc3r4JbmUnWmRJcY3JkDQaFO5lScmSr
         c8nA==
X-Gm-Message-State: AC+VfDzogtrO/HsSz86diSQd9dTuorDYmRUoUrxiB8H1/J/J111Fv6cl
        ALK4ynYaQ5r1f6sdNPJ5Vujs0daP8c9M4Q==
X-Google-Smtp-Source: ACHHUZ6BO+9JfsHIjm+yN/qCIlWJ1ctkc0uulsI8VGAinV2WKYKeKSoxBxT7ymyXQrVQ3UK3+jZ/DQ==
X-Received: by 2002:a05:620a:2cc3:b0:75b:23a1:3624 with SMTP id tc3-20020a05620a2cc300b0075b23a13624mr7313740qkn.53.1685605347652;
        Thu, 01 Jun 2023 00:42:27 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a136f00b0075b00e52e3asm6330942qkl.70.2023.06.01.00.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:42:25 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-75afeacb5e4so56394985a.3;
        Thu, 01 Jun 2023 00:42:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:75b:23a1:3603 with SMTP id
 ea16-20020a05620a489000b0075b23a13603mr8693674qkb.20.1685605345152; Thu, 01
 Jun 2023 00:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-31-vishal.moola@gmail.com> <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
In-Reply-To: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jun 2023 09:42:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
Message-ID: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Adrian,

On Thu, Jun 1, 2023 at 9:28 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-06-01 at 09:20 +0200, Geert Uytterhoeven wrote:
> > On Wed, May 31, 2023 at 11:33 PM Vishal Moola (Oracle)
> > <vishal.moola@gmail.com> wrote:
> > > Part of the conversions to replace pgtable constructor/destructors with
> > > ptdesc equivalents. Also cleans up some spacing issues.
> > >
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume this series is supposed to go through some mm tree?

I think so, so your Acked-by would be appreciated...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
