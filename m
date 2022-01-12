Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE948BF4B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 08:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348924AbiALHyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 02:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348876AbiALHyu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 02:54:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB60C061748;
        Tue, 11 Jan 2022 23:54:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso10438610pje.0;
        Tue, 11 Jan 2022 23:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ddbcgUQy2ACGWNObhkkWr7cYAjgrS2/NpX3SVZgBanA=;
        b=WBv4GQIxcRGangotyCbt//fiM1Lz11jdVPLZycyZblrYZFPmB/q0PIkmEd+qe70Vyg
         vTthNnErrfx+IuNXtgUdm5L+qMuEGXIV7/AFTVEmvafOiG1LREaCxCz65mBD4YDWGXv+
         kmLmaYGWDxzpdIptHErKO/0BBAbN1Phw73kW4dU/3A/+WT8buIw8WDIl4HhDq+Tm61rg
         fSG7NF7rSoaJFMLaaWmJh4OBsLXdss/VqDVV9PpWF8oxBaCtyOAVxm4ai/ysDtNOGjJh
         lZXOUwyqeBWE05Xt7rAxjAh4zaV0mUFULR2M+64m8J+0Oykfm/596fhaVtZ7R75DXb+k
         QFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ddbcgUQy2ACGWNObhkkWr7cYAjgrS2/NpX3SVZgBanA=;
        b=dHGGfbgY+9UHAgIdpLsr2znDMfRce6mle4Ce+t8YsDFY6D0QUZWJ9SR77GMEe0pUPz
         booKC6p0gABSxOFyMhRa1Zn4hrHPkW82GfZFsvW10wfMXLtLm04H6HxIIFxgAdtcXBRr
         3wv47knmEfbW4w+ywgC2v7szG4sQKVX5mX5JwlEI2nBZ8pYRHEE1bRk9IINoHC1mvky3
         4XbR9JvI/E0ub3cx3OXdzlAUGmExJwQNp7jgWRSCP8GuJJ2NSwVQzUTJj2px+EDwXnt6
         wm3q7C2+xDLIHk5Q98XjST8e2eAy2DT4JUbyGKrdVHIPS37lZj/zI2SFSuHVXkbyAZzw
         Kgww==
X-Gm-Message-State: AOAM531EjHqACqDRL2Ie6J828E9gmdKgM/8k5bJFKNiH3LAZ45TW10Bo
        XrIy1m1/j7BZq0cm8OFWOZ4=
X-Google-Smtp-Source: ABdhPJw8k5KAZAGaTerc9zDYCOtFDBKhkRXcvisgad9JG3JiyhDSRfS1pigx5bqT9dc8UwETrzdMXw==
X-Received: by 2002:a05:6a00:a90:b0:4bd:320a:d579 with SMTP id b16-20020a056a000a9000b004bd320ad579mr8311974pfl.47.1641974088535;
        Tue, 11 Jan 2022 23:54:48 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id k23sm5124495pji.3.2022.01.11.23.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jan 2022 23:54:47 -0800 (PST)
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
To:     Finn Thain <fthain@linux-m68k.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com>
 <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
 <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
 <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
 <acf7b627-2dec-c76c-2aa0-6b4c6addd793@gmail.com>
 <d660267-ce4f-e598-9b40-5cdbb4566c7@linux-m68k.org>
 <6060f799-d0c5-e4c2-a81c-2bd872ce3d5a@gmail.com>
 <b8ad3fc-523f-eca2-91d7-c77d20a1e876@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1a0ea2f0-d817-7261-b17e-c1f5f3a767e4@gmail.com>
Date:   Wed, 12 Jan 2022 20:54:37 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <b8ad3fc-523f-eca2-91d7-c77d20a1e876@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Finn,

Am 12.01.2022 um 16:32 schrieb Finn Thain:
> On Wed, 12 Jan 2022, Michael Schmitz wrote:
>
>>
>> I seem to recall we also tested those on your 040 and there was no
>> regression there, but I may be misremembering that.
>>
>
> I abandoned that regression testing exercise when unpatched mainline
> kernels began failing on that machine. I'm in the process of setting up a
> different 68040 machine.
>

Thanks for refreshing my memory!

Splitting my first patch as suggested by Al in order to defer handling 
of the syscall_trace_enter() return code would achieve what Geert 
suggested (eliminate m68k syscall_trace() altogether) without risk of 
regression. This would need to replace Eric's patch 8.

Do you want me to send such a version based on my old patch series, or 
would you rather prepare that yourself, Eric?

Cheers,

	Michael


