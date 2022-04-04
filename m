Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3F4F1006
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377694AbiDDHhA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiDDHg7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:36:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDD1165BF;
        Mon,  4 Apr 2022 00:35:03 -0700 (PDT)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N95mR-1o6qB70YlD-0167ZH; Mon, 04 Apr 2022 09:35:02 +0200
Received: by mail-wr1-f50.google.com with SMTP id b19so13023870wrh.11;
        Mon, 04 Apr 2022 00:35:02 -0700 (PDT)
X-Gm-Message-State: AOAM533q4EAh6WnaHs6wAGzbztrwbYwEregx/0nl6DBK+3E8w67CMKQD
        jLvqOXZGI6CdoClAP7GMEv+swa1440JeSaixtOU=
X-Google-Smtp-Source: ABdhPJwrecYOdkY3TJ48gqbFuXT/mD0XaIIYl5yZtNKXWERJKznl01pyz/ckYokgBEG0N3no2bo8h1E8PCUCLAMKglw=
X-Received: by 2002:a05:6000:10c7:b0:206:135e:c84e with SMTP id
 b7-20020a05600010c700b00206135ec84emr2006910wrx.12.1649057701673; Mon, 04 Apr
 2022 00:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
In-Reply-To: <20220404061948.2111820-1-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 09:34:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3RWypZ2H6zRTdEWMvg608VFVAoNAQZbUM4GbW7uAWk8A@mail.gmail.com>
Message-ID: <CAK8P3a3RWypZ2H6zRTdEWMvg608VFVAoNAQZbUM4GbW7uAWk8A@mail.gmail.com>
Subject: Re: [PATCH 0/8] UAPI: make more exported headers self-contained, and
 put them into test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:T15ZZ+wXFygrBFcuA38guq9hqE43alcNHM3kBQk/KHFcvqJiXow
 j/xOxrQ3t2LjER2qhm7qW26LDYrmQrf4p6gRT3htoixnCCICfBLHi7QUyeh8S23Igvji9FF
 YfDQtyjvAaxcwOk475JCxfCe72CVsYPlOX1wQG9DvLUs6yvtEmoylwiXhxJpZ7/AvoNKYIB
 /fbmgnrGnzRWIxzi5yqfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14+AXDMp6Eg=:9+jnsX4ZoMr/PGP6kxQoqE
 ypDPYKdwNWzMtoTQpYHBcjf5+FpDZS2Qd1Qovx9zTLqIdyWqgDKzmBjaRWQyyXlK8UvLXUtlj
 v6Yrgn3SmGq4wVNgndATXm3ndLrtEQHKw8rZgTxuKGgsThxbF0Le2v9NU2Nl8boilLgBsgSH0
 OhY3WejMJ1r+OK11SMRTvw8vKG7G1W/Sq0/l7OmNSPOj+1vx2RVIpXo/cmpQrHyqt7Xd2U503
 FYfVGN7OAg7eAs0WR/OJGzCDbbKK2NC5gsUdEGuQvmkvn5Jw98+E6mS1s6kv+NhQ9FD9HVfZ0
 ETGD87NLuOV7LNBb0qgUQtn1OlCCcWtxrqMeE17rNixtN33lLpwmnmEZwvzHDnfLh1KveJiuX
 OKJ89ceRgKSXzoBMRkIhzk9uzyxUEOW9jI/HIKLkWrCBtQM2QUDZUJrVuyfD2Qp5A4HKQAmfA
 9HUP1VmzW6P40J7h5nja7b3NHB96bXd/EfM/LpPFS5I5Rp9J9HVGO4HfN4ce572gHfzpnXB3x
 nJ8oet4f1d+NfHms7Lzc46KkKr49LQHFQ70dt/sFDlRy2VuGMxm4ZcU0zz0Ldyks1xxj692mG
 wGEbcfQ4Wu9AOElW1ziH1dOVLTttCMY6s0ejolO/wJwOMCuocuMIqoJSOdqzPjHhZfJaCu8Gy
 K6IMW5d4ZvYs3MIFwxtPsnFiOHN0B1dX8Nqm0lQjlg5FzyfN08IGbh6pCyfa1uHhYFQ8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 8:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> Here are more efforts to put more headers to UAPI compile testing
> (CONFIG_UAPI_HEADER_TEST).
>
> I am sending this series to Arnd because he has deep knowledge for the
> kernel APIs and manages asm-generic pull requests.

These all look good to me, I can apply them for 5.19 but would wait
a few days for others to comment.

       Arnd
