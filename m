Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A86C6A56
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 15:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCWOBd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCWOBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 10:01:11 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20738664;
        Thu, 23 Mar 2023 07:00:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C05C2420CF;
        Thu, 23 Mar 2023 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1679580025;
        bh=pyc0cPcoQuoGHqD2F1DqtYF/Nqt56WT0AaYfiPSX8UI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JSXvSaYwT1LMH3sZ6lGpRKg5J7UhlRfFVca97FNzFtb8lRl4Gw4AP7ISYExqBgKLu
         YnVgR2at604jbjV/gaj63fx8H8zZrUkZvlFqxJSPHLWAzZxGrYCk9R+rPq99VBsvEJ
         pZSSlECO2fxeF4MXyfMWT/EbilcDFVi/DPiV1skvWD9j8B2sONJaEwSw+zpLYAzaVf
         YbSLPzmWVuLHhEpeaYfM/VzPlQXH9/yOF0rPF2UPnAi89yUW0WcKs7k6j3FAHW+iCR
         EngCFfaOtDEocXoS7yia1fkj+jaQCiSwms8uGB3lP+HeVEbH6p8aXk8H9PNL99dbi6
         xIatmpAduZAWQ==
Message-ID: <be81649f-ff58-8c0a-8594-94ea1bd2ee4a@asahilina.net>
Date:   Thu, 23 Mar 2023 23:00:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] rust: ioctl: Add ioctl number manipulation functions
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        linux-arch@vger.kernel.org
References: <20230224-rust-ioctl-v3-1-3c5f7a6954b5@asahilina.net>
 <CANiq72nk+KSz6X0Lxg4kc_Bui=17XhboJ6q6j8gRg7Nsshziug@mail.gmail.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <CANiq72nk+KSz6X0Lxg4kc_Bui=17XhboJ6q6j8gRg7Nsshziug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23/03/2023 22.05, Miguel Ojeda wrote:
> On Thu, Mar 23, 2023 at 1:34 PM Asahi Lina <lina@asahilina.net> wrote:
>>
>> Changes in v3:
>> - Actually made the change intended in v2.
>> - Link to v2: https://lore.kernel.org/r/20230224-rust-ioctl-v2-1-5325e76a92df@asahilina.net
>>
>> Changes in v2:
>> - Changed from assert!() to build_assert!() (static_assert!() can't work
>>    here)
>> - Link to v1: https://lore.kernel.org/r/20230224-rust-ioctl-v1-1-5142d365a934@asahilina.net
> 
> It seems `#[inline(always)]` got added to a few of those, right? (The
> addition looks fine to me, but just to understand if is it an omission
> in the changelog, or an unintended change, or intended for another
> reason).

Ah yes, I should've mentioned that! build_assert!() only works for stuff 
that can be const-optimized at build time, which requires inlining. 
Otherwise this change immediately causes build failures since generic 
variants of the functions get compiled (and since they're public 
functions, cannot be optimized out at link time).

> 
> Thanks!
> 
> Cheers,
> Miguel
> 

~~ Lina

