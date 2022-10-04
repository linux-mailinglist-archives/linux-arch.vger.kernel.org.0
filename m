Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24E5F3B2E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 04:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJDCOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 22:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDCOC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 22:14:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF8838680;
        Mon,  3 Oct 2022 19:14:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so11824554pjk.2;
        Mon, 03 Oct 2022 19:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvantEeNxC3dSveGMMWou/gthfpOhD8SfiRVYxBXGlQ=;
        b=iAqud5MGNe+tgEPXaGvoyeLPttoje6ff6D8ctV2/4qznlDnoM9VrGu0kkPiuNonsGm
         RrofKv//4KbjsvFm+/15PlPLR7H8DTTkosuf5pq8EItSMb7JXVze6HDDIj4/nIq2NAAF
         pSv2Gd5vXu5u88+Y4duEQcZ5EXB/3fsbkf4vcTxcqjH+GtZCDmvIwTkdzKla72VGbayJ
         jZvhlCjCuutu721L7vF6katDFb5UI3OBRr1qHMwOODqGFmZfFQD2IjKeT70pgK6tS3PW
         245J32jRrZ6w//rwYhJlRhG6tx3FWRw4r7EFfEtNDPZ+4It+MOywDrlyALijW5YKcHtr
         uprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvantEeNxC3dSveGMMWou/gthfpOhD8SfiRVYxBXGlQ=;
        b=ys7xIz4+VgRGfKQr83tikCpiT4T9BLfnZ6OM53rEP1WWpy7404+rL4evOLfygwOyGo
         Etv/9TxWYX+epwCrkV+t0fi3RO2Rj7835iB2cbn8JM9TkpteA0V+Hr+cFij0jT4rjkVr
         NkCf77iWXuKEAISgMaALuw0tmAGk78YG05wfYi/rItBbGjiL2QyR7Bj2N8CQAC42s86l
         3sS8iRKuYgbM+FUymygCE+47QSxFJJuhSJ3LYm7Pkmv7mz4r3w1Z6xR+iBbR0eYEzTFP
         QUsL/ZR8bHlkG8SeuXSY29RQOaY7/mfLd3FiwmN5CpWYUuWiET1nlrh1cgyvwjITM0hA
         sYgQ==
X-Gm-Message-State: ACrzQf3Kj5AOYmbsVydI1HbUuO7rPV7d3ZrcPvjPSP/qvMO3r4kgnUkZ
        DjHmpsWoz6p552Ipq6QGfiY=
X-Google-Smtp-Source: AMsMyM6+K7Yo2XrQSF7PEaOky/6qt3MGbJRTpfABTUr/5YF4RdUtm2iIyhtC1Zn/1hAYhc1K30WYXQ==
X-Received: by 2002:a17:903:2cd:b0:179:cf09:4d8a with SMTP id s13-20020a17090302cd00b00179cf094d8amr25064575plk.107.1664849641361;
        Mon, 03 Oct 2022 19:14:01 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b00176c431e7e2sm7813018plc.13.2022.10.03.19.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 19:14:00 -0700 (PDT)
Message-ID: <646d1a93-fbdb-d1c7-a61a-74ae1cc17cce@gmail.com>
Date:   Tue, 4 Oct 2022 09:13:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me>
 <4102e1ef-c0da-37b7-6b54-89027fd9d080@nvidia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <4102e1ef-c0da-37b7-6b54-89027fd9d080@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/4/22 02:35, John Hubbard wrote:
> It's always a judgment call, as to whether to use something like ``CALL`
> or just plain CALL. Here, I'd like to opine that that the benefits of
> ``CALL`` are very small, whereas plain text in cet.rst has been made
> significantly worse. So the result is, "this is not worth it".
> 

Hmm, seems like neither CALL nor ``CALL`` is better, right?

-- 
An old man doll... just what I always wanted! - Clara
