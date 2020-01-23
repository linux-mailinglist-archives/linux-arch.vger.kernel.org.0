Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF895147031
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWR7Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 12:59:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37842 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWR7Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 12:59:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so3018883lfc.4
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdFWsGYP+/xokr+Jc40CYV8I3yOJTReQRwsZpMafAIU=;
        b=eYCXt9KuCjSWsxKT/LS/oRbB0oCaiHnqj4H6RJ7QasqoCu3gRsmkjJE0XL+lw9FM4Z
         Utq4fAiOjg0fs8R1CeLtZy+7kX5ZX+QDtdxpqRuAg+ACSnejnWkdBli2iyS3I+Y8xyg8
         2ry2FHh/zgNd68ry0JVzr2TgceUB6QJzCCqn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdFWsGYP+/xokr+Jc40CYV8I3yOJTReQRwsZpMafAIU=;
        b=mC24Z5DFPsBeiLbcf9yga55FaQT4HR7i5R8dPbIxkcxqM29Mft4vEe93sLI1bgVcmn
         zL4Z1vaR84JaNWQKbMEnyXkmAvZlImUUqD+ImZc5oVcQGk2qZ5FYKUWS/PO8fIOjrpvY
         LVdymn/qQiZ1UeGQfcDGcgHUltaIDXp04cnQf9UsgMIlbvjxfXIGfepc8hlKbCkDI4G5
         CFND4DIdKueEbDcdH3rf4KQ4Yp08GX3jv0VdNZN2klt5wX+yB6boObfGpbs70GKydQER
         vlunAV3fFBMQPAK4UbXy/olwLqo+jYpvjRt6L7onZhJno/rJpwmBI2NHtseyPVfwS6R7
         1f5Q==
X-Gm-Message-State: APjAAAUYhAm/dBNVlVWyEDSAATCP+u5L1hx1AUhkP+lcIK8R2bfg6vpM
        9EazMGqPLWNSBAWQ85AZ3QxNNFlUXGM=
X-Google-Smtp-Source: APXvYqwZfWlpYHMfjPtdXaTaAYE/GFByw5g0jRP7dxS2oNdPvtV+izfULGqQEkd0rxT6B0qJQLmYWg==
X-Received: by 2002:a19:f10e:: with SMTP id p14mr5245983lfh.3.1579802360809;
        Thu, 23 Jan 2020 09:59:20 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i1sm1668982lji.71.2020.01.23.09.59.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:59:19 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id n18so4555946ljo.7
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 09:59:19 -0800 (PST)
X-Received: by 2002:a2e:9510:: with SMTP id f16mr23701334ljh.249.1579802359199;
 Thu, 23 Jan 2020 09:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org>
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 09:59:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Message-ID: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
>
> This is version two of the patches I previously posted as an RFC here:

Looks fine to me, as far as I can tell,

              Linus
