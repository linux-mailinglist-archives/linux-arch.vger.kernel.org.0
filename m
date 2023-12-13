Return-Path: <linux-arch+bounces-960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B81810B25
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C921B1C20A1F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971931774D;
	Wed, 13 Dec 2023 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S134qtgw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7FE4
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so45075e9.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702451606; x=1703056406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XiVBoQNOk3tLc5XlULuzrSVDQ7J5EwukNNrHWQSQk+4=;
        b=S134qtgwd78qFopwS84Q3HNv/nVI3iqAGbM5M3b8letKBqZM06D0u5UpfAkplXQZlh
         ImpNgyC/vxFsrflALncE4Dcw4LM/8D6xEOiKv1EzIzfx+JcGyLKQjfxqG3m+paHMrWsm
         8+rOMLfOW+jlV9IfPY7QHSQ8kvFv83KiOakOzJMPj5gPCW1RsSvso22YN9pjKuzT29tL
         BdavxOFwFYPCNAb3FchkMQ+zroqtR5xamEHO7vB0VFjWhDpbLsC4BWjWy72uGCmm8ova
         MjsBEFoHj/oZUtT/pSBbvD8UspT1MuIUqET7nhzTDSbjn4AVcXMqQHVrB6+DHnzcY7yk
         aZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451606; x=1703056406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiVBoQNOk3tLc5XlULuzrSVDQ7J5EwukNNrHWQSQk+4=;
        b=wUK6ej53MdrKMs8rL2k0lGgxootynhZ7ivOO3eGZxSWbzZSNgn6ndpFcHLC4iXWs7S
         VnOzacaK380yJ7nTvhfMRDaQlHVqL/Yrj5ms5ZVa5LgUQqO/pMSZxgm3tzsRtAHXQGVz
         /2PCF8kcdWSF16NQahQZTpjhJpZ+hNBDyMHgAdKYKeLtzX9/zWLZ168+vYjPBNfMFaVz
         NOcwR3TxXQ/KWo8N3wD/dip3rGyJK4hD/+XhknoKKRXTSdJ/KMhR4ziBiyG9y1OVjiUF
         RQHj6lX1vzyRzXxhUe1lKwiCosWlOsZqKc8kdKVnhZcV7HAZzTw82tEhKpULxgpOglaf
         Ie0g==
X-Gm-Message-State: AOJu0YwJPGXGkdvmh/abekKQEvHOVH3aPohZMrnMUiPk15afMSpPDgq2
	XEZzCinXbWs/BQ8lCZIWqVgQl7a6xCbmlkUypkeSlg==
X-Google-Smtp-Source: AGHT+IEdkfaw2sPjSCFPAKnsDQixAjMlNYWQSFZGQUMnexKI8o8FqkFlsBxuZrKnt9l82zjzMIYCh2Uri5cHZKe6sOA=
X-Received: by 2002:a05:600c:3b20:b0:40c:1e46:508e with SMTP id
 m32-20020a05600c3b2000b0040c1e46508emr398986wms.0.1702451605968; Tue, 12 Dec
 2023 23:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com>
In-Reply-To: <20231213010201.1802507-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Dec 2023 15:13:12 +0800
Message-ID: <CABVgOS=5mJx8zAipgU=QGXxYusukQ0ePienJTnp_51vs1gJD4A@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000404ed7060c5ee764"

--000000000000404ed7060c5ee764
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 09:02, Rae Moar <rmoar@google.com> wrote:
>
> Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
> into DATA_DATA.
>
> Data for KUnit tests does not need to be in the init section.
>
> In order to run tests again after boot the KUnit data cannot be labeled as
> init data as the kernel could write over it.
>
> Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
> data/functions.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good to me.

This shouldn't be strictly necessary for the rest of the series, but
will be useful for future features which depend on having the
suite_set around after boot.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Changes since v3:
> - No changes
>
>  include/asm-generic/vmlinux.lds.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index bae0fe4d499b..1107905d37fc 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -370,7 +370,8 @@
>         BRANCH_PROFILE()                                                \
>         TRACE_PRINTKS()                                                 \
>         BPF_RAW_TP()                                                    \
> -       TRACEPOINT_STR()
> +       TRACEPOINT_STR()                                                \
> +       KUNIT_TABLE()
>
>  /*
>   * Data section helpers
> @@ -699,8 +700,7 @@
>         THERMAL_TABLE(governor)                                         \
>         EARLYCON_TABLE()                                                \
>         LSM_TABLE()                                                     \
> -       EARLY_LSM_TABLE()                                               \
> -       KUNIT_TABLE()
> +       EARLY_LSM_TABLE()
>
>  #define INIT_TEXT                                                      \
>         *(.init.text .init.text.*)                                      \
>
> base-commit: b285ba6f8cc1b2bfece0b4350fdb92c8780bc698
> --
> 2.43.0.472.g3155946c3a-goog
>

--000000000000404ed7060c5ee764
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAV
PXbbnEIDlr+faPjhQEcGSdR7Wo3jatbAllOCi6OZ7TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTMwNzEzMjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEeXqpBkFpfohCByxy68P
fPOQykYFiVxKSuSvL+Za0wTOSac1z45D0Jig2VAzk2maVFgEd74dYo+qy0zWN9GClA+ypTqLeShF
GrAC/oYUYRu5NPJzQPkf8Xn5bkdMNRnq0mlDXnvGPmUOQT3FiFdr+/BiwOMAqhppipw1BtRCB2rn
jE9eJtfLHYc3MaRFqKewaX7kJpoKabjN28idxfZKK9oZ6nO2uSVBHAZaMJQw1DullbZTGSbXECuF
wA4ZGYoOCJCWvaC0VLoTVSsJMjza/X3DrbNMw1gOLXoLkiNayd9wTa0M3VKPiMJK+HC7Le/pGgBs
Mtl3ldnOqQy254zy6w==
--000000000000404ed7060c5ee764--

