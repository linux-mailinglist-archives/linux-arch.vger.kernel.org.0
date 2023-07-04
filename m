Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535807476B4
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGDQ26 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGDQ2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 12:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955ED1BD6
        for <linux-arch@vger.kernel.org>; Tue,  4 Jul 2023 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688488067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHdgPj1Wm2IgY2fHBO70NHanGv82Rz5Bml4kSaFfUEk=;
        b=jCwEbiV78yYy+2kz0mYUu/xOOcW+HRcoh9pUaVZwoqlbjPJvwYbCxtM6W+gIlxzoWzWLS4
        ps5qQSQ5akNYq/4k0kjIe16br+5UpnRkhVPLhy5CYcq4IwE52oXCwHsMOm82YH0YBy3RRG
        Plv0smLrvJIEcqFXxNmcA/XrMEG9LjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-RJqje2JyPOGnRR-GJJyN_Q-1; Tue, 04 Jul 2023 12:27:46 -0400
X-MC-Unique: RJqje2JyPOGnRR-GJJyN_Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbab56aac7so36511145e9.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Jul 2023 09:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488065; x=1691080065;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHdgPj1Wm2IgY2fHBO70NHanGv82Rz5Bml4kSaFfUEk=;
        b=ZS43oAYEej7r850RW8Hm6oKu2ZGwn6XGaZfMSxU55iCpi8XAiIFZchycgIRuPNvDXo
         DSfrLu5fcctPsFGjemDeyAHdtU8wItkMC1qHuX7PbxiFLySi1tX+SzitkMJf7l9Q1634
         lEqmt2euFHhHBBIJrW3g90p9HUnflZ2yygYz0Me1jgPC5kGDpJpnTxC0tgCLXjIybzjZ
         nRkxiGhqGR0vwetTU93Rop4NatGAXyPEv36DDhrPm69UBWsvgXig8y1BJ9iPj+C8HP07
         jYRNsZADbTj52BUYQp5RnXRX0iQbBsu7dCeqbvIPENgM6kLnXP5YsDFzwvvlO+uX5kzH
         FbSQ==
X-Gm-Message-State: AC+VfDx3YkLOjymQQaTRSJTkxYUJHudyq8lr0R6MiyPOApIsGBGyGZhc
        f2FaCEo7qovaqakSkzTykNNKVUjt3mbHXseiCEsSLx5NNH3h9IEdlc8ftu9XXNrQo+aZNa0HpaX
        1Dy+ygMb5jikKOVX2u+Nj8Q==
X-Received: by 2002:a05:600c:2181:b0:3fa:96ae:fd78 with SMTP id e1-20020a05600c218100b003fa96aefd78mr12439035wme.29.1688488065020;
        Tue, 04 Jul 2023 09:27:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76jB5JrX6TXp/j+SpnZTGNMceWk0U9GUm8msLFZPg0J8xzTJ2Ph/XYxtIjAMzvUbO/YmFVwQ==
X-Received: by 2002:a05:600c:2181:b0:3fa:96ae:fd78 with SMTP id e1-20020a05600c218100b003fa96aefd78mr12439000wme.29.1688488064598;
        Tue, 04 Jul 2023 09:27:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm22214385wmj.39.2023.07.04.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:27:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, Rich Felker <dalias@libc.org>,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-csky@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        loongarch@lists.linux.dev,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 05/12] arch: Remove trailing whitespaces
In-Reply-To: <20230629121952.10559-6-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-6-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:27:43 +0200
Message-ID: <877crflk00.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

