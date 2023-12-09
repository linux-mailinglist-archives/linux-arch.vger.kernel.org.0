Return-Path: <linux-arch+bounces-853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2F80B2E7
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 08:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D3AB20B2E
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05F63CE;
	Sat,  9 Dec 2023 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2tpSE3m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BD10EF
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 23:57:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso18565e9.1
        for <linux-arch@vger.kernel.org>; Fri, 08 Dec 2023 23:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702108659; x=1702713459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4wRUm3STqdeql0nz8gpy9luKmBXWWcdU5SIuWeuhzg=;
        b=X2tpSE3mi1hJ16qAJkA0j70IVy8bYkbbL2YSl0aL2V6iQ80wnRRzkfhXXdGYF8e/3h
         jxH/+uEA9bHy4l5kqnSKi3yOrw8Gi+QcmmxQXkSIlaomHKSHhQWKRwYZYPsL25Y8zTso
         3jG1/wGUkq7Q0GXaSh6iTX0/B4aOV39B+4PjhnFPn2y4J7Xzq0uqMcBVGShC9xuT/p63
         Rlxv1Y5CYrE0eEwLc6UhUYFY9UTgBhON9Wglee5F0Be5acN6ZNva8Tr5A9fa6I/RmBCu
         NJjv5PaFz/rUNSiZuOd1PRwyzd6YFLN8MKD0yx3hUKXNrglNA4O5vfZLwlvmcmX05SrC
         uJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702108659; x=1702713459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4wRUm3STqdeql0nz8gpy9luKmBXWWcdU5SIuWeuhzg=;
        b=qbffjtQECHu8FX5QC6Gi752JmsIw6KByYzNMBfw071nGPdRc93k8AZpbfU4ckr3IxZ
         CGQ26t4XVhaDGcfZB+SEp8IjyqP0tlRIkkAJavdrqUnZH5e3ayo4ZZ822n+bgl/kK98m
         582NPIT1oNqWe3MXAdyqsOjz16ucz7VRLobDsBgCgJZHjIi74YMCyzOpDBIYBOn90OwP
         pH8XYsCCrj/oXodkBGfCEx1RVxBEws0b31xgMoOWZ7PhNFFHDNAl7A8yeFDf9obWwT8Y
         e8cI1TQotzE+lYvlhRU+jzLamyi8slj5hd0B8IrzeeeTwR/qV3uIuk+0bmLS+Rpb9wg/
         Lyig==
X-Gm-Message-State: AOJu0YzqXrxhaSpg3y3j0RDQkOXAOIl01sEdGwryF88LkZFI/t8IQIyo
	gZo2VRpRpzSsnVkJTgVEdyRw564u0gzq3d0wy3nj3Q==
X-Google-Smtp-Source: AGHT+IGc2kQcyb5PeJtRja8T59KYZs+rRrblriN0acUXYPGU86FVOB58Izgw00OtRXAU6d4zvS40RCj3Anew6rP1S0c=
X-Received: by 2002:a05:600c:2941:b0:405:320a:44f9 with SMTP id
 n1-20020a05600c294100b00405320a44f9mr115852wmd.5.1702108658620; Fri, 08 Dec
 2023 23:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <20231204221932.1465004-2-rmoar@google.com>
In-Reply-To: <20231204221932.1465004-2-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 9 Dec 2023 15:57:27 +0800
Message-ID: <CABVgOSmz_9c_Gj3U+uqwhio96txj7bvpe1Ncn6RU3rf7Q8uKrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] kunit: add KUNIT_INIT_TABLE to init linker section
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ff3562060c0f0d4a"

--000000000000ff3562060c0f0d4a
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
>
> Add KUNIT_INIT_TABLE to the INIT_DATA linker section.
>
> Alter the KUnit macros to create init tests:
> kunit_test_init_section_suites
>
> Update lib/kunit/executor.c to run both the suites in KUNIT_TABLE and
> KUNIT_INIT_TABLE.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This works well here.

I'm still a little bit conflicted around the idea of merging suite
sets at runtime -- I think there could be more efficient ways of
handling that -- though the more I think about it, the less worried
I'm getting (since we'll need to keep init suites around somewhere for
debugfs, anyway, right?).

In fact, that's something we probably need to work out -- is it legal
for the actual kunit_test_suite struct to be __initdata? I'd thought
so, but if we need to loop over these later in debugfs to keep their
logs, then probably not. Unless you wanted to make a copy of the
kunit_suite itself, not just the pointers to it (though that seems
excessive).

If we're settled on that (the suite itself can't be __initdata), then this is:
Reviewed-by: David Gow <davidgow@google.com>

-- David

>  include/asm-generic/vmlinux.lds.h |  9 ++++-
>  include/kunit/test.h              | 10 ++++-
>  include/linux/module.h            |  2 +
>  kernel/module/main.c              |  3 ++
>  lib/kunit/executor.c              | 64 ++++++++++++++++++++++++++++---
>  lib/kunit/test.c                  | 26 +++++++++----
>  6 files changed, 99 insertions(+), 15 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1107905d37fc..5dd3a61d673d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -700,7 +700,8 @@
>         THERMAL_TABLE(governor)                                         \
>         EARLYCON_TABLE()                                                \
>         LSM_TABLE()                                                     \
> -       EARLY_LSM_TABLE()
> +       EARLY_LSM_TABLE()                                               \
> +       KUNIT_INIT_TABLE()
>
>  #define INIT_TEXT                                                      \
>         *(.init.text .init.text.*)                                      \
> @@ -926,6 +927,12 @@
>                 . = ALIGN(8);                                           \
>                 BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
>
> +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> +#define KUNIT_INIT_TABLE()                                             \
> +               . = ALIGN(8);                                           \

I still hate that we hardcode '8' here, but I guess we've got no
choice in a linker script.


> +               BOUNDED_SECTION_POST_LABEL(.kunit_init_test_suites, \
> +                               __kunit_init_suites, _start, _end)
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS                                                    \
>         . = ALIGN(4);                                                   \
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 20ed9f9275c9..06e826a0b894 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -337,6 +337,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
>  void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin);
>  void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr);
>
> +struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
> +               struct kunit_suite_set suite_set);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> @@ -371,6 +374,11 @@ static inline int kunit_run_all_tests(void)
>
>  #define kunit_test_suite(suite)        kunit_test_suites(&suite)
>
> +#define __kunit_init_test_suites(unique_array, ...)                           \
> +       static struct kunit_suite *unique_array[]                              \
> +       __aligned(sizeof(struct kunit_suite *))                                \
> +       __used __section(".kunit_init_test_suites") = { __VA_ARGS__ }
> +
>  /**
>   * kunit_test_init_section_suites() - used to register one or more &struct
>   *                                   kunit_suite containing init functions or
> @@ -392,7 +400,7 @@ static inline int kunit_run_all_tests(void)
>   * this manner.
>   */
>  #define kunit_test_init_section_suites(__suites...)                    \
> -       __kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),    \
> +       __kunit_init_test_suites(__UNIQUE_ID(array),                    \
>                             ##__suites)
>
>  #define kunit_test_init_section_suite(suite)   \
> diff --git a/include/linux/module.h b/include/linux/module.h
> index a98e188cf37b..9cd0009bd050 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -540,6 +540,8 @@ struct module {
>         struct static_call_site *static_call_sites;
>  #endif
>  #if IS_ENABLED(CONFIG_KUNIT)
> +       int num_kunit_init_suites;
> +       struct kunit_suite **kunit_init_suites;
>         int num_kunit_suites;
>         struct kunit_suite **kunit_suites;
>  #endif
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98fedfdb8db5..36681911c05a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2199,6 +2199,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>         mod->kunit_suites = section_objs(info, ".kunit_test_suites",
>                                               sizeof(*mod->kunit_suites),
>                                               &mod->num_kunit_suites);
> +       mod->kunit_init_suites = section_objs(info, ".kunit_init_test_suites",
> +                                             sizeof(*mod->kunit_init_suites),
> +                                             &mod->num_kunit_init_suites);
>  #endif
>
>         mod->extable = section_objs(info, "__ex_table",
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 1236b3cd2fbb..847329c51e91 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -12,6 +12,8 @@
>   */
>  extern struct kunit_suite * const __kunit_suites_start[];
>  extern struct kunit_suite * const __kunit_suites_end[];
> +extern struct kunit_suite * const __kunit_init_suites_start[];
> +extern struct kunit_suite * const __kunit_init_suites_end[];
>
>  static char *action_param;
>
> @@ -292,6 +294,33 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
>         }
>  }
>
> +struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
> +               struct kunit_suite_set suite_set)
> +{
> +       struct kunit_suite_set total_suite_set = {NULL, NULL};
> +       struct kunit_suite **total_suite_start = NULL;
> +       size_t init_num_suites, num_suites, suite_size;
> +
> +       init_num_suites = init_suite_set.end - init_suite_set.start;
> +       num_suites = suite_set.end - suite_set.start;
> +       suite_size = sizeof(suite_set.start);
> +
> +       /* Allocate memory for array of all kunit suites */
> +       total_suite_start = kmalloc_array(init_num_suites + num_suites, suite_size, GFP_KERNEL);
> +       if (!total_suite_start)
> +               return total_suite_set;
> +
> +       /* Append init suites and then all other kunit suites */
> +       memcpy(total_suite_start, init_suite_set.start, init_num_suites * suite_size);
> +       memcpy(total_suite_start + init_num_suites, suite_set.start, num_suites * suite_size);
> +
> +       /* Set kunit suite set start and end */
> +       total_suite_set.start = total_suite_start;
> +       total_suite_set.end = total_suite_start + (init_num_suites + num_suites);
> +
> +       return total_suite_set;
> +}
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
>  static char *kunit_shutdown;
> @@ -313,21 +342,41 @@ static void kunit_handle_shutdown(void)
>
>  int kunit_run_all_tests(void)
>  {
> -       struct kunit_suite_set suite_set = {
> +       struct kunit_suite_set suite_set = {NULL, NULL};
> +       struct kunit_suite_set filtered_suite_set = {NULL, NULL};
> +       struct kunit_suite_set init_suite_set = {
> +               __kunit_init_suites_start, __kunit_init_suites_end,
> +       };
> +       struct kunit_suite_set normal_suite_set = {
>                 __kunit_suites_start, __kunit_suites_end,
>         };
> +       size_t init_num_suites = init_suite_set.end - init_suite_set.start;
>         int err = 0;
> +
> +       if (init_num_suites > 0) {
> +               suite_set = kunit_merge_suite_sets(init_suite_set, normal_suite_set);
> +               if (!suite_set.start)
> +                       goto out;
> +       } else
> +               suite_set = normal_suite_set;
> +
>         if (!kunit_enabled()) {
>                 pr_info("kunit: disabled\n");
> -               goto out;
> +               goto free_out;
>         }
>
>         if (filter_glob_param || filter_param) {
> -               suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
> +               filtered_suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
>                                 filter_param, filter_action_param, &err);
> +
> +               /* Free original suite set before using filtered suite set */
> +               if (init_num_suites > 0)
> +                       kfree(suite_set.start);
> +               suite_set = filtered_suite_set;
> +
>                 if (err) {
>                         pr_err("kunit executor: error filtering suites: %d\n", err);
> -                       goto out;
> +                       goto free_out;
>                 }
>         }
>
> @@ -340,9 +389,12 @@ int kunit_run_all_tests(void)
>         else
>                 pr_err("kunit executor: unknown action '%s'\n", action_param);
>
> -       if (filter_glob_param || filter_param) { /* a copy was made of each suite */
> +free_out:
> +       if (filter_glob_param || filter_param)
>                 kunit_free_suite_set(suite_set);
> -       }
> +       else if (init_num_suites > 0)
> +               /* Don't use kunit_free_suite_set because suites aren't individually allocated */
> +               kfree(suite_set.start);
>
>  out:
>         kunit_handle_shutdown();
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f2eb71f1a66c..8bae6e2bc6a0 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -704,28 +704,40 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>  #ifdef CONFIG_MODULES
>  static void kunit_module_init(struct module *mod)
>  {
> -       struct kunit_suite_set suite_set = {
> +       struct kunit_suite_set suite_set, filtered_set;
> +       struct kunit_suite_set normal_suite_set = {
>                 mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
>         };
> +       struct kunit_suite_set init_suite_set = {
> +               mod->kunit_init_suites, mod->kunit_init_suites + mod->num_kunit_init_suites,
> +       };
>         const char *action = kunit_action();
>         int err = 0;
>
> -       suite_set = kunit_filter_suites(&suite_set,
> +       if (mod->num_kunit_init_suites > 0)
> +               suite_set = kunit_merge_suite_sets(init_suite_set, normal_suite_set);
> +       else
> +               suite_set = normal_suite_set;
> +
> +       filtered_set = kunit_filter_suites(&suite_set,
>                                         kunit_filter_glob() ?: "*.*",
>                                         kunit_filter(), kunit_filter_action(),
>                                         &err);
>         if (err)
>                 pr_err("kunit module: error filtering suites: %d\n", err);
>
> -       mod->kunit_suites = (struct kunit_suite **)suite_set.start;
> -       mod->num_kunit_suites = suite_set.end - suite_set.start;
> +       mod->kunit_suites = (struct kunit_suite **)filtered_set.start;
> +       mod->num_kunit_suites = filtered_set.end - filtered_set.start;
> +
> +       if (mod->num_kunit_init_suites > 0)
> +               kfree(suite_set.start);
>
>         if (!action)
> -               kunit_exec_run_tests(&suite_set, false);
> +               kunit_exec_run_tests(&filtered_set, false);
>         else if (!strcmp(action, "list"))
> -               kunit_exec_list_tests(&suite_set, false);
> +               kunit_exec_list_tests(&filtered_set, false);
>         else if (!strcmp(action, "list_attr"))
> -               kunit_exec_list_tests(&suite_set, true);
> +               kunit_exec_list_tests(&filtered_set, true);
>         else
>                 pr_err("kunit: unknown action '%s'\n", action);
>  }
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

--000000000000ff3562060c0f0d4a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDZ
VycFKGAhD7oX79YWNFsFIcQBXArQ4LKwAGGSj1AtOTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMDkwNzU3MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACAjiNyYMTIPs8uCGbWdH
R4wKramEUKo+xN5+II146zfB2VGjriuklVrK/oy23djFQwZlM7u+DdvBqkDNCa72nF4oUeawAI8A
nU7/PfEfLQaH8zG/kpV/l4swhguhFnfiT1fvklB3RSa+3CzBalPvqn/0AhyOH0LXB7tdGohPuVUE
pgjKVfTE6d7eLU0UaVkEXiNrVe1qtr5XiJPvLvaPalZI0rwbAqX5UkKJFPJg4KLS2XoA5MMgifES
RGAfRElVZd6S5AA9LhTFt5oWMwxbZEIvEgf8htI2kkhW9Enc26oV6mb1oxNuK8RxxOR3G1ReC79J
xeip0Qske63dPvDkcg==
--000000000000ff3562060c0f0d4a--

