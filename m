Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7F5A6F85
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiH3Vti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiH3Vte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:49:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390B8E9AB
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:49:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3363b1dffa0so189707667b3.23
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc;
        bh=nkzMCqKgjBTn+NwznXGF4FkMKBv5sNXeON2LIxVXB6M=;
        b=kJlmMVVbY7IXNl91XGcBvO3YBT3quRQF4WCS0SiH4LOLG/e+9p2jaPHVw9E6t43+lu
         d4/47XlZrYUEtJ7XQ4VgzKUrbfj5xy9BOKDP//VyLPwp6hXR8zYzPt3dQTar5Wyr4GYS
         iZIbWUJ75o4n7+UgTsXC+An80tm2UyPOQgFq5wJiP9bNIbl98o3r9SGFN0OGKpWzVCwL
         D90b1H3jXLeXTLKjKOyg3XK2WfiVlhvPG/TS9Z+MZLclTKFSEr9IlFYU0A0pKe+sQn6L
         rk2/ZWVdc/gD2rOE75MuQ1Xdte4UkYIWIQjcJTwqiH4rcTqyxgiTvaJazxYK/g79dGii
         T0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc;
        bh=nkzMCqKgjBTn+NwznXGF4FkMKBv5sNXeON2LIxVXB6M=;
        b=KPvtHVZG/vuOYEyIwoTrNU9c+q3uWiKcMShFQwwJiLi/xX4qf28QxWH+9bXDPHC0RF
         btgFkK0+wqps28yFehMFaG6K4XdE8uXG6BMGTuyYQgq8QjUf2UEUEX00WjC3vHbK39sp
         pPq6h4VWt0a9QUxoezl3jNivw3E9gH2BoXwXriC7wUT41GUFFdQUl9mwg90STJ0xBcOY
         ZT/rf1GIp8fUByp7gD95OMU0Hz9Uks8ojYqeattYuhusIKF/+tJu+mUW0Ns5MbfB1HZT
         vo+ap7STQN8I2dJMSfhNpLNfa+WsPuwkwzNxSJaff/CeCiaraPT3RPu80j1tYdQVZ/lJ
         7+cw==
X-Gm-Message-State: ACgBeo27W6TDjdyueWqbwJi1Aq/2hWY0KCFmGCUjWxBES+uKuwgl8/Qc
        ciMA+cRA60euGz53mv6KnP0rMR5m5/Q=
X-Google-Smtp-Source: AA6agR58VLI71n7hWTuP/n58j09zS0GpQ603/kDNR321OvTW6NJyNZKRSs+4OQb0POQ9FkLHMKokHnLGLkM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:e90e:0:b0:695:64cf:5d2 with SMTP id
 n14-20020a25e90e000000b0069564cf05d2mr12975575ybd.541.1661896169455; Tue, 30
 Aug 2022 14:49:29 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:48:51 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-3-surenb@google.com>
Subject: [RFC PATCH 02/30] lib/string_helpers: Drop space in string_get_size's output
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        iommu@lists.linux.dev, kasan-dev@googlegroups.com,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=" <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

Previously, string_get_size() outputted a space between the number and
the units, i.e.
  9.88 MiB

This changes it to
  9.88MiB

which allows it to be parsed correctly by the 'sort -h' command.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/string_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5ed3beb066e6..3032d1b04ca3 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -126,8 +126,7 @@ void string_get_size(u64 size, u64 blk_size, const enum=
 string_size_units units,
 	else
 		unit =3D units_str[units][i];
=20
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	snprintf(buf, len, "%u%s%s", (u32)size, tmp, unit);
 }
 EXPORT_SYMBOL(string_get_size);
=20
--=20
2.37.2.672.g94769d06f0-goog

