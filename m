Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA39F2B4DE9
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbgKPRjN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:39:13 -0500
Received: from m12-15.163.com ([220.181.12.15]:33217 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731548AbgKPRjL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Nov 2020 12:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=pyfE1
        H0/1VRREqBOrFUhDkSuLgxJI4AYr08Md7sn1rM=; b=bCQbdeZDnfgvo9ygivG54
        tASmWXSWno7wHyou+2E8ibkg0NwIV4UvvN9P/yDU+Np6lxUSfc5opGR3bQJG05Y+
        ijJHjOCGFDBycuCpBVlqX+cwhuakoJt0eqxGytoRWV0EpgRHWqJzEbBjn8s+Cpid
        c/nWBfr9WQcUArTKgy7+QM=
Received: from [192.168.0.103] (unknown [120.229.59.172])
        by smtp11 (Coremail) with SMTP id D8CowAA3hzdstbJfbvHEBQ--.60045S3;
        Tue, 17 Nov 2020 01:22:56 +0800 (CST)
Subject: Re: [PATCH 1/3] lib: Introduce copy_from_back()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
References: <20201109191601.14053-1-zengzhaoxiu@163.com>
 <20201116163523.GA18835@infradead.org>
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
Message-ID: <092552df-204e-beee-58f8-da194b866d0f@163.com>
Date:   Tue, 17 Nov 2020 01:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116163523.GA18835@infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAA3hzdstbJfbvHEBQ--.60045S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3uF17ZryUurWkWFW5Zr1UWrg_yoWkAFWUp3
        W3Ka42y39rZry8Kry5ZF48u343J393AayIkF9rJry3uF17Gr1YgFW7K34jqr9FvrZ7Aa4a
        yr9IqFyYyrWkAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-eOJUUUUU=
X-Originating-IP: [120.229.59.172]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbByhDegF0COy0T6QAAs3
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ÔÚ 2020/11/17 0:35, Christoph Hellwig Ð´µÀ:
> On Tue, Nov 10, 2020 at 03:16:01AM +0800, zengzhaoxiu@163.com wrote:
>> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
>>
>> Copying the matched bytes from the back output buffer is the
>> key code of the LZ decompression algorithm which used by zlib, lzo, etc.
>>
>> This patch introduce the optimized copy_from_back function.
>> The function will be used by later patches in this series.
>>
>> Optimization for a specific architecture will be available in the future.
>>
>> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Please use mandatory-y in include/asm-generic/Kbuild for the case where
> we have a sensible default that only a few architectures want to
> override.
> 

Thanks a lot£¡

---
 include/asm-generic/Kbuild           |   1 +
 include/asm-generic/copy_from_back.h | 414 +++++++++++++++++++++++++++
 2 files changed, 415 insertions(+)
 create mode 100644 include/asm-generic/copy_from_back.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index e78bbb9a07e9..84964a32572c 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -12,6 +12,7 @@ mandatory-y += bugs.h
 mandatory-y += cacheflush.h
 mandatory-y += checksum.h
 mandatory-y += compat.h
+mandatory-y += copy_from_back.h
 mandatory-y += current.h
 mandatory-y += delay.h
 mandatory-y += device.h
diff --git a/include/asm-generic/copy_from_back.h b/include/asm-generic/copy_from_back.h
new file mode 100644
index 000000000000..3786c947734e
--- /dev/null
+++ b/include/asm-generic/copy_from_back.h
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COPY_FROM_BACK_H
+#define __COPY_FROM_BACK_H
+
+#include <linux/types.h>
+
+#define FAST_COPY_SAFEGUARD_SIZE (sizeof(long) * 2 - 1)
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+
+/*
+ * The caller must ensure that the output buffer has enough space (len + FAST_COPY_SAFEGUARD_SIZE),
+ * so we can write 2 words per loop without overflowing the output buffer
+ */
+static __always_inline u8 *copy_from_back_fast(u8 *out, size_t dist, size_t len)
+{
+	u8 *end = out + len;
+
+	/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+	if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+		/* extend the distance '1,2,3' to '4,4,6' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+		/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		*(u32 *)(out + 3) = *(u32 *)(out - ((0x43213110 >> (dist * 4)) & 0xF));
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+	}
+
+	do {
+		*(unsigned long *)out = *(unsigned long *)(out - dist);
+		out += sizeof(long);
+		*(unsigned long *)out = *(unsigned long *)(out - dist);
+		out += sizeof(long);
+	} while (out < end);
+
+	return end;
+}
+
+static __always_inline u8 *copy_from_back(u8 *out, size_t dist, size_t len)
+{
+	if (len >= sizeof(long)) {
+		/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+		if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+			/* extend the distance '1,2,3' to '4,4,6' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+			/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			*(u32 *)(out + 3) = *(u32 *)(out - ((0x43213110 >> (dist * 4)) & 0xF));
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+		}
+
+		while (len >= sizeof(long) * 2) {
+			len -= sizeof(long) * 2;
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+		}
+		if (len >= sizeof(long)) {
+			len -= sizeof(long);
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+		}
+		if (len) {
+			unsigned long val;
+
+			out += len;
+			val = *(unsigned long *)(out - sizeof(long) - dist);
+			*(unsigned long *)(out - sizeof(long)) = val;
+		}
+	} else {
+		*out = *(out - dist);
+		out++;
+		len--;
+_last:
+		if (len >= 2) {
+			if (dist == 1)
+				dist = 2;
+#if BITS_PER_LONG == 32
+			*(u16 *)out = *(u16 *)(out - dist);
+			out += 2;
+			len -= 2;
+#else
+			do {
+				*(u16 *)out = *(u16 *)(out - dist);
+				out += 2;
+				len -= 2;
+			} while (len >= 2);
+#endif
+		}
+		if (len) {
+			*out = *(out - dist);
+			out++;
+		}
+	}
+
+	return out;
+}
+
+#else /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
+
+#include <asm/unaligned.h>
+
+/*
+ * Endian independent macros for shifting bits
+ */
+#ifdef __BIG_ENDIAN
+# define LSPULL(x, n)	((x) << (n))
+# define LSPUSH(x, n)	((x) >> (n))
+# define LSMASK(n)		(~(~0UL >> (n)))
+# define LSFETCH(x, n)	((x) >> (BITS_PER_LONG - (n)))
+#else
+# define LSPULL(x, n)	((x) >> (n))
+# define LSPUSH(x, n)	((x) << (n))
+# define LSMASK(n)		((1UL << (n)) - 1)
+# define LSFETCH(x, n)	((x) & LSMASK(n))
+#endif
+
+/*
+ * The caller must ensure that the output buffer has enough space (len + FAST_COPY_SAFEGUARD_SIZE),
+ * so we can write 2 words per loop without overflowing the output buffer
+ */
+static __always_inline u8 *copy_from_back_fast(u8 *out, size_t dist, size_t len)
+{
+	u8 *end = out + len;
+	unsigned long val;
+	unsigned int n;
+
+	/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+	if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+		/* extend the distance '1,2,3' to '4,4,6' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+		/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		out[3] = out[3 - dist];
+		out[4] = out[4 - dist];
+		out[5] = out[5 - dist];
+		out[6] = out[6 - dist];
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+	}
+
+	/* align out addr */
+	n = (uintptr_t)out & (sizeof(long) - 1);
+	if (n) {
+		val = get_unaligned((unsigned long *)(out - dist));
+		put_unaligned(val, (unsigned long *)out);
+		out += sizeof(long);
+		if (out >= end)
+			return end;
+		out -= n;
+	}
+
+	n = dist & (sizeof(long) - 1);
+	if (n) {
+		const unsigned int shift_h = n * 8, shift_l = BITS_PER_LONG - shift_h;
+		unsigned long prev;
+
+		dist -= n;
+		prev = *(unsigned long *)(out - dist - sizeof(long));
+
+		do {
+			val = *(unsigned long *)(out - dist);
+			*(unsigned long *)out = LSPULL(prev, shift_l) | LSPUSH(val, shift_h);
+			out += sizeof(long);
+			prev = *(unsigned long *)(out - dist);
+			*(unsigned long *)out = LSPULL(val, shift_l) | LSPUSH(prev, shift_h);
+			out += sizeof(long);
+		} while (out < end);
+	} else {
+		do {
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+		} while (out < end);
+	}
+
+	return end;
+}
+
+static __always_inline u8 *copy_from_back(u8 *out, size_t dist, size_t len)
+{
+	unsigned long val;
+	unsigned int n;
+
+	if (len >= sizeof(long)) {
+		/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+		if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+			/* extend the distance '1,2,3' to '4,4,6' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+			/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			out[3] = out[3 - dist];
+			out[4] = out[4 - dist];
+			out[5] = out[5 - dist];
+			out[6] = out[6 - dist];
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+		}
+
+		/* align out addr */
+		n = (uintptr_t)out & (sizeof(long) - 1);
+		if (n) {
+			val = get_unaligned((unsigned long *)(out - dist));
+			put_unaligned(val, (unsigned long *)out);
+			out += sizeof(long);
+			len -= sizeof(long);
+			if (len < sizeof(long)) {
+				if (len)
+					goto _last;
+				return out;
+			}
+			out -= n;
+			len += n;
+		}
+
+		n = dist & (sizeof(long) - 1);
+		if (n) {
+			const unsigned int shift_h = n * 8, shift_l = BITS_PER_LONG - shift_h;
+			unsigned long prev;
+
+			dist -= n;
+			prev = *(unsigned long *)(out - dist - sizeof(long));
+
+			while (len >= sizeof(long) * 2) {
+				len -= sizeof(long) * 2;
+				val = *(unsigned long *)(out - dist);
+				*(unsigned long *)out = LSPULL(prev, shift_l) | LSPUSH(val, shift_h);
+				out += sizeof(long);
+				prev = *(unsigned long *)(out - dist);
+				*(unsigned long *)out = LSPULL(val, shift_l) | LSPUSH(prev, shift_h);
+				out += sizeof(long);
+			}
+			if (len >= sizeof(long)) {
+				len -= sizeof(long);
+				val = *(unsigned long *)(out - dist);
+				*(unsigned long *)out = LSPULL(prev, shift_l) | LSPUSH(val, shift_h);
+				out += sizeof(long);
+				prev = val;
+			}
+			if (len) {
+				val = LSPULL(prev, shift_l);
+				if (len * 8 > shift_h) {
+					prev = *(unsigned long *)(out - dist);
+					val |= LSPUSH(prev, shift_h);
+				}
+				goto _part;
+			}
+		} else if (dist != sizeof(long)) {
+			while (len >= sizeof(long) * 2) {
+				len -= sizeof(long) * 2;
+				*(unsigned long *)out = *(unsigned long *)(out - dist);
+				out += sizeof(long);
+				*(unsigned long *)out = *(unsigned long *)(out - dist);
+				out += sizeof(long);
+			}
+			if (len >= sizeof(long)) {
+				len -= sizeof(long);
+				*(unsigned long *)out = *(unsigned long *)(out - dist);
+				out += sizeof(long);
+			}
+			if (len) {
+				val = *(unsigned long *)(out - dist);
+				goto _part;
+			}
+		} else {
+			val = *(unsigned long *)(out - sizeof(long));
+			while (len >= sizeof(long) * 2) {
+				len -= sizeof(long) * 2;
+				*(unsigned long *)out = val;
+				out += sizeof(long);
+				*(unsigned long *)out = val;
+				out += sizeof(long);
+			}
+			if (len >= sizeof(long)) {
+				len -= sizeof(long);
+				*(unsigned long *)out = val;
+				out += sizeof(long);
+			}
+			if (len) {
+_part:
+#if BITS_PER_LONG == 64
+				if (len & 4) {
+					*(u32 *)out = LSFETCH(val, 32);
+					out += 4;
+					val = LSPULL(val, 32);
+				}
+#endif
+				if (len & 2) {
+					*(u16 *)out = LSFETCH(val, 16);
+					out += 2;
+					val = LSPULL(val, 16);
+				}
+				if (len & 1)
+					*out++ = LSFETCH(val, 8);
+			}
+		}
+	} else {
+_last:
+		/* Align out addr */
+		if ((uintptr_t)out & 1) {
+			*out = *(out - dist);
+			out++;
+			len--;
+		}
+		if (len >= 2) {
+#if BITS_PER_LONG == 32
+			if (dist > 1)
+				*(u16 *)out = get_unaligned((u16 *)(out - dist));
+			else
+				*(u16 *)out = out[-1] | out[-1] << 8;
+			out += 2;
+			len -= 2;
+#else
+			if (dist > 2) {
+				do {
+					*(u16 *)out = get_unaligned((u16 *)(out - dist));
+					out += 2;
+					len -= 2;
+				} while (len >= 2);
+			} else {
+				val = dist == 2 ? *(u16 *)(out - 2) : (out[-1] | out[-1] << 8);
+				do {
+					*(u16 *)out = val;
+					out += 2;
+					len -= 2;
+				} while (len >= 2);
+			}
+#endif
+		}
+		if (len) {
+			*out = *(out - dist);
+			out++;
+		}
+	}
+
+	return out;
+}
+
+#undef LSPULL
+#undef LSPUSH
+#undef LSMASK
+#undef LSFETCH
+
+#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
+
+#endif /* __COPY_FROM_BACK_H */
-- 
2.28.0



