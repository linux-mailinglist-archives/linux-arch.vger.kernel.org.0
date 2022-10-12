Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8866A5FCAEF
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 20:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJLSsb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJLSsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 14:48:30 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CBBC4DB7
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 11:48:29 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so20427518fac.11
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ESROyxdmNaMCuLAvwDxLztz/p3doaWu/k516wwQHrw=;
        b=TxUslp/5MFOT246DWlq1s20VNKGGSSTTxByLdcsEMJmdAKLTiDSE0c2Hq5L+HVw4JY
         W5kDSqOsorAPAC0AWFewpZG+wc6mkemgAROu3M43P7g+Nr+xOV2FWfEaSoXlwIz/0n0U
         SxfcCTSnFEGvvBl9RwIWsBnbuy5EkfYyyf6ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ESROyxdmNaMCuLAvwDxLztz/p3doaWu/k516wwQHrw=;
        b=g7AD11yiZ0jusCHY78e5ASLsp7lF0wrDaRTva/V3iaeyzxirSSgrNh5H+QXIfzfrkj
         nm+BPHdfmdZOJZuwNVxYcAaYlaFbyfwRMeQK0WSF2etG2BRjY2pY5K7UA8HtzZ8hOjXS
         SHZA/Cmh5HCZLk2nk/5vCWq+hVw6ceGA7a0A4541dQlXSy0CKEdtUdoGCXPDHMBrrgcr
         EcAH5V3QFXtvVRrS/qo08dJJmJTEGV8S503ua8W/niPZ630hOmwsxJNbsLRwezhmMI6W
         6+Xzq3egxNAuQ0CkXQP/AFUvsMmxaVkRicyNlV1OCwnZMn+P6khr03bs23rwufofLEHQ
         ozDw==
X-Gm-Message-State: ACrzQf1AK3/62GA/RzeiTE3Q0I2e9TsHhH2UAyGqKqIumxGLhb9e869g
        8LGOnnbvCnGSOm7CMvZZG4J0bK7mo+DLSw==
X-Google-Smtp-Source: AMsMyM5cLWfJN/+bjYv2ChKqte7wpL4q2o1RNgX4AASeq/CPRr9SxZftbBmVtRbvYLvX6ekhsDC/ww==
X-Received: by 2002:a05:6870:51a:b0:130:ae8d:daaf with SMTP id j26-20020a056870051a00b00130ae8ddaafmr3135655oao.103.1665600508649;
        Wed, 12 Oct 2022 11:48:28 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id t12-20020a4ad0ac000000b0047537233dfasm1254989oor.21.2022.10.12.11.48.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 11:48:27 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id r11-20020a4aa2cb000000b004806f49e27eso6657423ool.7
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 11:48:27 -0700 (PDT)
X-Received: by 2002:a4a:4e41:0:b0:480:8a3c:a797 with SMTP id
 r62-20020a4a4e41000000b004808a3ca797mr2985303ooa.71.1665600507237; Wed, 12
 Oct 2022 11:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221012181841.333325-1-masahiroy@kernel.org>
In-Reply-To: <20221012181841.333325-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 11:48:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTCVWhFz1MK22hq9WNEmhKy2kpNerA3fyyBYzP7z8XWg@mail.gmail.com>
Message-ID: <CAHk-=whTCVWhFz1MK22hq9WNEmhKy2kpNerA3fyyBYzP7z8XWg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: raise minimum supported version of
 binutils to 2.25
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Wed, Oct 12, 2022 at 11:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Bump the binutils version to 2.25, which was released one year before
> GCC 5.1.

Ack, sounds sane.

               Linus
